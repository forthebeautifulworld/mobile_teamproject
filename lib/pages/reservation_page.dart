// 예약 페이지를 위한 Flutter StatefulWidget
import 'package:flutter/material.dart';
import '../models/table_status.dart'; // 테이블 상태 모델 파일의 경로가 올바른지 확인해야 합니다.

/// ReservationPage 위젯 정의
class ReservationPage extends StatefulWidget {
  ReservationPage({Key? key}) : super(key: key); // Key 매개변수 추가

  @override
  ReservationPageState createState() => ReservationPageState(); // 상태 객체 생성
}

/// ReservationPage의 상태 클래스
class ReservationPageState extends State<ReservationPage> {
  // 테이블 상태를 저장하는 리스트
  List<TableStatus> tableStatuses = [
    TableStatus(
        id: 1,
        seats: 12,
        maxSeats: 13,
        status: TableState.available,
        shape: TableShape.rectangle),
    TableStatus(
        id: 2,
        seats: 6,
        maxSeats: 7,
        status: TableState.unavailable,
        shape: TableShape.rectangle),
    TableStatus(
        id: 3,
        seats: 4,
        maxSeats: 4,
        status: TableState.available,
        shape: TableShape.square),
    TableStatus(
        id: 4,
        seats: 6,
        maxSeats: 7,
        status: TableState.available,
        shape: TableShape.rectangle),
    TableStatus(
        id: 5,
        seats: 6,
        maxSeats: 7,
        status: TableState.available,
        shape: TableShape.rectangle),
    TableStatus(
        id: 6,
        seats: 2,
        maxSeats: 3,
        status: TableState.available,
        shape: TableShape.square),
    TableStatus(
        id: 7,
        seats: 6,
        maxSeats: 7,
        status: TableState.available,
        shape: TableShape.rectangle),
    TableStatus(
        id: 8,
        seats: 6,
        maxSeats: 7,
        status: TableState.available,
        shape: TableShape.rectangle),
    TableStatus(
        id: 9,
        seats: 4,
        maxSeats: 6,
        status: TableState.available,
        shape: TableShape.square),
    // 추가 테이블 상태를 이곳에 정의
    TableStatus(
        id: 10,
        seats: 4,
        maxSeats: 6,
        status: TableState.available,
        shape: TableShape.square),
    TableStatus(
        id: 11,
        seats: 4,
        maxSeats: 6,
        status: TableState.available,
        shape: TableShape.square),
    TableStatus(
        id: 12,
        seats: 4,
        maxSeats: 6,
        status: TableState.available,
        shape: TableShape.square)
  ];

  int? selectedTableId; // 선택된 테이블 ID 저장

  /// 예약 다이얼로그를 보여주기 위한 함수
  void _showReservationDialog(int tableId) {
    // 테이블 ID로 테이블 상태 객체 찾기
    final table = tableStatuses.firstWhere((table) => table.id == tableId);

    // 텍스트 입력 컨트롤러 초기화
    TextEditingController timeController = TextEditingController();
    TextEditingController peopleController = TextEditingController();

    // 예약 정보 입력 다이얼로그 표시
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("예약 정보 입력"), // 다이얼로그 제목
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: timeController,
                decoration:
                    const InputDecoration(labelText: "방문 시간"), // 방문 시간 입력 필드
              ),
              TextField(
                controller: peopleController,
                decoration:
                    const InputDecoration(labelText: "방문 인원수"), // 방문 인원수 입력 필드
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("취소"), // 취소 버튼
              onPressed: () {
                setState(() {
                  selectedTableId = null; // 선택된 테이블 초기화
                });
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
            TextButton(
              child: const Text("확정"), // 확정 버튼
              onPressed: () {
                // 입력한 인원수 확인
                int peopleCount = int.tryParse(peopleController.text) ?? 0;
                if (peopleCount > table.maxSeats) {
                  // 입력한 인원수가 테이블 최대 인원수를 초과한 경우 오류 메시지 표시
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("오류"), // 오류 메시지 다이얼로그 제목
                        content:
                            const Text("테이블의 최대 인원수를 확인해주세요."), // 오류 메시지 내용
                        actions: [
                          TextButton(
                            child: const Text("확인"), // 확인 버튼
                            onPressed: () {
                              Navigator.of(context).pop(); // 오류 메시지 다이얼로그 닫기
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // 인원수가 문제 없을 경우 예약 처리
                  setState(() {
                    table.status = TableState.myReserved; // 테이블 상태를 내 예약으로 변경
                    table.visitTime = timeController.text; // 방문 시간 저장
                    table.visitPeople = peopleController.text; // 방문 인원수 저장
                    selectedTableId = null; // 선택된 테이블 초기화
                  });
                  Navigator.of(context).pop(); // 예약 정보 입력 다이얼로그 닫기
                }
              },
            ),
          ],
        );
      },
    );
  }

  /// 위젯 빌드 함수
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("테이블 예약"), // 앱바 제목
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // 뒤로가기 아이콘
          onPressed: () {
            Navigator.pop(context); // 뒤로가기 동작
          },
        ),
      ),
      body: Center(
        child: Container(
          color: const Color(0xFFE0BEE0), // 배경색 지정
          child: Stack(
            children: [
              // 테이블 위젯 빌드 - 여러 개의 테이블을 중첩하여 배치
              buildTable(tableStatuses[0], 20, 20,
                  width: 380, height: 80), // 큰 직사각형 테이블
              buildTable(tableStatuses[1], 120, 20,
                  width: 80, height: 160), // 높은 직사각형 테이블
              // 이곳에 추가 테이블 빌드를 추가할 수 있습니다.
              const Positioned(
                bottom: 20,
                left: 160,
                child: Text(
                  "출입구",
                  style: TextStyle(fontSize: 18, color: Colors.red), // 출입구 표시
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // 나머지 코드는 다음 주석에서 따로 제공됩니다.

  /// 테이블을 빌드하는 함수
  Widget buildTable(TableStatus table, double top, double left,
      {double width = 80, double height = 80}) {
    // 테이블 상태에 따라서 다른 색상을 설정
    Color tableColor;
    switch (table.status) {
      case TableState.available:
        tableColor = Colors.white; // 사용 가능 상태일 때 흰색
        break;
      case TableState.unavailable:
        tableColor = Colors.pink; // 사용 불가 상태일 때 분홍색
        break;
      case TableState.reserved:
        tableColor = Colors.red; // 예약됨 상태일 때 빨간색
        break;
      case TableState.myReserved:
        tableColor = Colors.green; // 내 예약 상태일 때 초록색
        break;
      default:
        tableColor = Colors.white; // 기본 색상으로 흰색
        break;
    }
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onTap: table.status == TableState.available
            ? () {
                setState(() {
                  selectedTableId = table.id; // 선택된 테이블 ID 설정
                  _showReservationDialog(table.id); // 예약 다이얼로그 표시
                });
              }
            : table.status == TableState.myReserved
                ? () {
                    // 내 예약 상태일 때 예약 상세 정보를 보여주는 다이얼로그 표시
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("내 예약 정보"), // 다이얼로그 제목
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("방문 시간: ${table.visitTime}"), // 방문 시간 표시
                              Text("방문 인원수: ${table.visitPeople}"), // 방문 인원수 표시
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: const Text("예약 취소하기"), // 예약 취소 버튼
                              onPressed: () {
                                setState(() {
                                  table.status = TableState
                                      .available; // 테이블 상태를 사용 가능으로 변경
                                });
                                Navigator.of(context).pop(); // 다이얼로그 닫기
                              },
                            ),
                            TextButton(
                              child: const Text("확인"), // 확인 버튼
                              onPressed: () {
                                Navigator.of(context).pop(); // 다이얼로그 닫기
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                : null, // 다른 상태일 때 동작 없음
        child: Container(
          width: width, // 테이블 너비
          height: height, // 테이블 높이
          decoration: BoxDecoration(
            color: table.id == selectedTableId
                ? Colors.orange
                : tableColor, // 선택된 테이블의 색상은 주황색
            borderRadius: BorderRadius.circular(10.0), // 테이블의 모서리를 둥글게
            border: Border.all(color: Colors.black), // 테두리는 검은색
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${table.seats}", // 현재 좌석 수
                  style: const TextStyle(fontSize: 24), // 글자 크기 24
                ),
                Text(
                  "~${table.maxSeats}", // 최대 좌석 수
                  style: const TextStyle(fontSize: 12), // 글자 크기 12
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
