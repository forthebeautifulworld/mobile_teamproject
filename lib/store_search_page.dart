import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'home_page.dart';
import 'pages/restaurant_page.dart';

class StoreSearchPage extends StatefulWidget {
  const StoreSearchPage({Key? key}) : super(key: key);

  @override
  _StoreSearchPageState createState() => _StoreSearchPageState();
}

class _StoreSearchPageState extends State<StoreSearchPage> {
  int nrow = 0; // 가게 수를 저장할 변수
  List<String> businessNumbers = []; // 가게의 사업자 번호를 저장할 리스트

  final List<Map<String, int>> locations = [
    {"left": 350, "top": 220},
    {"left": 150, "top": 200},
    {"left": 250, "top": 300},
    {"left": 350, "top": 400},
    // 필요한 만큼 위치를 추가
  ]; // 가게 마커의 위치를 저장할 리스트

  @override
  void initState() {
    super.initState();
    _fetchStoreData(); // 가게 데이터를 가져오는 메서드 호출
  }

  Future<void> _fetchStoreData() async {
    final count = await DatabaseHelper().getStoreCount(); // 데이터베이스에서 가게 수 가져오기
    final numbers = await DatabaseHelper().getBusinessNumbers(); // 데이터베이스에서 사업자 번호 가져오기
    setState(() {
      nrow = count;
      businessNumbers = numbers;
    });
  }

  List<Widget> _buildMarkers() {
    List<Widget> markers = [
      Positioned(
        left: 100,
        top: 480,
        child: IconButton(
          icon: const Icon(
            Icons.location_on,
            size: 40.0,
            color: Colors.red,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RestaurantPage(businessNumber: 'whale_pizza'), // 'whale_pizza' 사업자 번호를 가진 가게 페이지로 이동
              ),
            );
          },
        ),
      ),
    ];

    for (int i = 0; i < nrow && i < locations.length; i++) {
      markers.add(Positioned(
        left: locations[i]["left"]!.toDouble(),
        top: locations[i]["top"]!.toDouble(),
        child: IconButton(
          icon: const Icon(
            Icons.location_on,
            size: 40.0,
            color: Colors.red,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RestaurantPage(businessNumber: businessNumbers[i]), // 해당 사업자 번호를 가진 가게 페이지로 이동
              ),
            );
          },
        ),
      ));
    }
    return markers; // 생성된 가게 마커 위젯 리스트 반환
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // 뒤로 가기 버튼 클릭 시 이전 페이지로 이동
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/map.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ), // 배경 이미지 설정
          ),
          ..._buildMarkers(), // 가게 마커 위젯 추가
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "My Info",
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(userInfo: {}), // 홈 페이지로 이동
              ),
            );
          }
          // 다른 탭을 클릭했을 때의 로직 추가 가능
        },
      ),
    );
  }
}