//store_search_page.dart
import 'package:flutter/material.dart';
import 'home_page.dart';

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
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/map.png', // 吏��룄 �씠誘몄�� �뙆�씪 寃쎈줈
              fit: BoxFit.cover,
              width: double.infinity,
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
              MaterialPageRoute(builder: (context) => HomePage(userInfo: {})),
            );
          } else if (index == 1) {
            // My Info �럹�씠吏�濡� �씠�룞
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const MyInfoPage()),
            // );
          }
        },
      ),
    );
  }
}
