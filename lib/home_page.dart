import 'package:flutter/material.dart';
import 'store_search_page.dart';
import 'store_register_page.dart';
import 'store_list_page.dart';
import 'my_info_page.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> userInfo; // 사용자 정보를 저장할 Map

  const HomePage({super.key, required this.userInfo});

  @override
  HomePageState createState() => HomePageState();
}
class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/default_profile.jpeg'), // 프로필 이미지 경로
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.userInfo.isNotEmpty)
                  Text(widget.userInfo['name']),
                // 사용자 정보가 없으면 기본 텍스트 출력
                if (widget.userInfo.isEmpty)
                  const Text('Guest'),
              ],
            ),
            const Spacer(),

          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "지금 생각나는 음식이 있나요?",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            // 추가된 부분 시작
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StoreSearchPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding:
                      const EdgeInsets.symmetric(vertical: 30), // 패딩 60
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 60),
                          child: Text(
                            "매장 찾기",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 60),
                          child: Icon(
                            Icons.map,
                            color: Colors.white,
                            size: 80, // 기본 크기의 5배
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StoreRegisterPage(),
                          settings: RouteSettings(arguments: widget.userInfo),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding:
                      const EdgeInsets.symmetric(vertical: 30), // 패딩 60
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 60),
                          child: Icon(
                            Icons.store,
                            color: Colors.white,
                            size: 80, // 기본 크기의 5배
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 60),
                          child: Text(
                            "매장 등록",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const StoreListPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(vertical: 30),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 60),
                          child: Text(
                            "매장 목록",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 60),
                          child: Icon(
                            Icons.list,
                            color: Colors.white,
                            size: 80,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 추가된 부분 종료
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("우리 동네 이벤트",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () {
                          // 아무 기능도 없음
                        },
                        child: const Text("view more"),
                      ),
                    ],
                  ),
                  _buildEventList(),
                ],
              ),
            ),
          ],
        ),
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
            // HomePage로 이동하는 코드가 이미 있음
          } else if (index == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyInfoPage(userInfo: widget.userInfo)),
            );
          }
        },
      ),
    );
  }

  Widget _buildEventList() {
    return Column(
      children: [
        _buildEventItem(
            'assets/images/store1.png', "복신", "시험기간 볶음밥 할인 이벤트!!", 4.8),
        const SizedBox(height: 10),
        _buildEventItem(
            'assets/images/store2.png', "고수찜닭", "3인분 이상 주문시 치즈토핑 무료!", 4.5),
      ],
    );
  }

  Widget _buildEventItem(
      String imagePath, String storeName, String description, double rating) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          height: 60,
          width: 60,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                storeName,
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(description),
            ],
          ),
        ),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.yellow),
            Text(rating.toString()),
          ],
        ),
      ],
    );
  }
}