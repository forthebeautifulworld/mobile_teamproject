import 'package:flutter/material.dart';
import 'package:mobile_team_project/models/table_status.dart'; // 경로가 올바른지 확인

class ReservationPage extends StatefulWidget {
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
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

  int? selectedTableId;

  void _showReservationDialog(int tableId) {
    final table = tableStatuses.firstWhere((table) => table.id == tableId);
    TextEditingController timeController = TextEditingController();
    TextEditingController peopleController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("예약 정보 입력"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: timeController,
                decoration: InputDecoration(labelText: "방문 시간"),
              ),
              TextField(
                controller: peopleController,
                decoration: InputDecoration(labelText: "방문 인원수"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("취소"),
              onPressed: () {
                setState(() {
                  selectedTableId = null;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("확정"),
              onPressed: () {
                int peopleCount = int.tryParse(peopleController.text) ?? 0;
                if (peopleCount > table.maxSeats) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("오류"),
                        content: Text("테이블의 최대 인원수를 확인해주세요."),
                        actions: [
                          TextButton(
                            child: Text("확인"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  setState(() {
                    table.status = TableState.myReserved;
                    table.visitTime = timeController.text;
                    table.visitPeople = peopleController.text;
                    selectedTableId = null;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("테이블 예약"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          color: Color(0xFFE0BEE0),
          child: Stack(
            children: [
              buildTable(tableStatuses[0], 20, 20,
                  width: 380, height: 80), // Large rectangle
              buildTable(tableStatuses[1], 120, 20,
                  width: 80, height: 160), // Tall rectangle
              buildTable(tableStatuses[2], 120, 130,
                  width: 80, height: 80), // Rectangle
              buildTable(tableStatuses[3], 120, 240,
                  width: 160, height: 80), // Square
              buildTable(tableStatuses[4], 240, 240,
                  width: 160, height: 80), // Rectangle
              buildTable(tableStatuses[5], 300, 20,
                  width: 80, height: 80), // Rectangle
              buildTable(tableStatuses[6], 400, 20,
                  width: 80, height: 160), // Square
              buildTable(tableStatuses[7], 580, 20,
                  width: 80, height: 160), // Square
              buildTable(tableStatuses[8], 480, 200,
                  width: 80, height: 80), // Square
              buildTable(tableStatuses[9], 480, 300,
                  width: 80, height: 80), // Square
              buildTable(tableStatuses[10], 580, 200, width: 80, height: 80),
              buildTable(tableStatuses[11], 580, 300,
                  width: 80, height: 80), // Tall rectangle
              Positioned(
                bottom: 20,
                left: 160,
                child: Text(
                  "출입구",
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTable(TableStatus table, double top, double left,
      {double width = 80, double height = 80}) {
    Color tableColor;
    switch (table.status) {
      case TableState.available:
        tableColor = Colors.white;
        break;
      case TableState.unavailable:
        tableColor = Colors.pink;
        break;
      case TableState.reserved:
        tableColor = Colors.red;
        break;
      case TableState.myReserved:
        tableColor = Colors.green;
        break;
      default:
        tableColor = Colors.white;
        break;
    }
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onTap: table.status == TableState.available
            ? () {
                setState(() {
                  selectedTableId = table.id;
                  _showReservationDialog(table.id);
                });
              }
            : table.status == TableState.myReserved
                ? () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("내 예약 정보"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("방문 시간: ${table.visitTime}"),
                              Text("방문 인원수: ${table.visitPeople}"),
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: Text("예약 취소하기"),
                              onPressed: () {
                                setState(() {
                                  table.status = TableState.available;
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text("확인"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                : null,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: table.id == selectedTableId ? Colors.orange : tableColor,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.black),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${table.seats}",
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  "~${table.maxSeats}",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
