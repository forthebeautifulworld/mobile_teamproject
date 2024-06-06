import 'package:flutter/material.dart';
import '../tabs/menu_tab.dart';
import '../tabs/community_tab.dart';
import '../pages/reservation_page.dart';

class RestaurantPage extends StatefulWidget {
  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Container(),
          leading: IconButton(
            icon:
                Image.asset('assets/images/back_button.png'), // 뒤로가기 버튼 이미지 경로
            onPressed: () {
              Navigator.pop(context); // 뒤로가기 기능 구현
            },
          ),
        ),
        body: Column(
          children: [
            Image.asset('assets/images/top_pizza_image.png', fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                '고래한입피자 단국대점',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            PreferredSize(
              preferredSize: Size.fromHeight(48.0),
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(text: '메뉴'),
                      const Tab(text: '커뮤니티'),
                    ],
                  ),
                  Container(
                    color: Colors.purple,
                    height: 4.0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  MenuTab(),
                  CommunityTab(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _tabController.index == 0
            ? ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReservationPage()),
                  );
                },
                child: const Text('예약하기'),
              )
            : null,
      ),
    );
  }
}
