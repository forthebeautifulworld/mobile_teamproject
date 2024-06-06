import 'package:flutter/material.dart';
import 'home_page.dart';
import 'pages/restaurant_page.dart'; // 새로 추가한 레스토랑 페이지 임포트

class StoreSearchPage extends StatelessWidget {
  const StoreSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // 지도 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/images/map.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          // 가운데 마커 아이콘
          Center(
            child: IconButton(
              icon: const Icon(
                Icons.location_on,
                size: 40.0,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RestaurantPage()),
                );
              },
            ),
          ),
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
                  builder: (context) => const HomePage(userInfo: {})),
            );
          }
          // 다른 탭을 클릭했을 때의 로직 추가 가능
        },
      ),
    );
  }
}
