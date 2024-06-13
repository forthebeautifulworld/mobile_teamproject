import 'package:flutter/material.dart';
import '../tabs/menu_tab.dart'; // 메뉴 탭 페이지 import
import '../tabs/community_tab.dart'; // 커뮤니티 탭 페이지 import
import '../pages/reservation_page.dart'; // 예약 페이지 import

// StatefulWidget을 사용해 RestaurantPage를 만듭니다.
class RestaurantPage extends StatefulWidget {
  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

// _RestaurantPageState는 RestaurantPage의 상태 클래스입니다.
class _RestaurantPageState extends State<RestaurantPage>
    with SingleTickerProviderStateMixin {
  // TabController 선언 (라임타임과 탭의 상태를 관리)
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // TabController 초기화 (탭의 개수: 2개)
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Tab 변화를 감지하여 상태 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Container(), // 비어있는 타이틀
          leading: IconButton(
            icon: Image.asset('assets/images/back_button.png'), // 뒤로가기 버튼 이미지
            onPressed: () {
              Navigator.pop(context); // 뒤로가기 기능 구현
            },
          ),
        ),
        body: Column(
          children: [
            // 상단 이미지
            Image.asset('assets/images/top_pizza_image.png', fit: BoxFit.cover),
            // 레스토랑 이름과 스타일
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
            // 탭 바와 컨테이너
            PreferredSize(
              preferredSize: Size.fromHeight(48.0),
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(text: '메뉴'), // 메뉴 탭
                      const Tab(text: '커뮤니티'), // 커뮤니티 탭
                    ],
                  ),
                  Container(
                    color: Colors.purple, // 탭 아래의 컬러라인
                    height: 4.0,
                  ),
                ],
              ),
            ),
            // TabBarView 정의
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  MenuTab(), // 메뉴 탭 페이지
                  CommunityTab(), // 커뮤니티 탭 페이지
                ],
              ),
            ),
          ],
        ),
        // 예약하기 버튼
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _tabController.index == 0 // 첫 번째 탭에서만 예약하기 버튼 표시
            ? ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReservationPage()), // 예약페이지로 이동
                  );
                },
                child: const Text('예약하기'),
              )
            : null, // 두 번째 탭에서는 버튼 표시 안함
      ),
    );
  }
}
