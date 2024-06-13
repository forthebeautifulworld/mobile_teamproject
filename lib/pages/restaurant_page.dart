import 'package:flutter/material.dart';
import 'package:teamproject123/tabs/default_community_tab.dart';
import '../tabs/menu_tab.dart';
import '../tabs/community_tab.dart';
import '../tabs/default_tab.dart'; // 기본 탭 import 추가
import '../pages/reservation_page.dart';
import '../database_helper.dart';

// 식당 페이지를 위한 상태 비저장 위젯
class RestaurantPage extends StatefulWidget {
  final String businessNumber;

  // 생성자
  const RestaurantPage({Key? key, required this.businessNumber})
      : super(key: key);

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

// 식당 페이지의 상태 클래스
class _RestaurantPageState extends State<RestaurantPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String storeName = '';

  @override
  void initState() {
    super.initState();
    // 두 개의 탭을 가진 탭 컨트롤러 초기화
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // 탭 변경 시 상태를 업데이트
    });
    // 가게 이름을 비동기적으로 가져옴
    _fetchStoreName();
  }

  // 가게 이름을 데이터베이스에서 가져오는 메서드
  Future<void> _fetchStoreName() async {
    if (widget.businessNumber == 'whale_pizza') {
      // 고래피자 죽전점의 경우 하드코딩된 이름 사용
      setState(() {
        storeName = '고래피자 죽전점';
      });
    } else {
      // 데이터베이스에서 비즈니스 번호로 가게 이름을 가져옴
      String name = await DatabaseHelper()
          .getStoreNameByBusinessNumber(widget.businessNumber);
      setState(() {
        storeName = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 중첩된 스크롤 뷰
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            // 확장 가능한 앱바
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  widget.businessNumber == 'whale_pizza'
                      ? 'assets/images/top_pizza_image.png'
                      : 'assets/images/default_image.png',
                  fit: BoxFit.cover,
                ),
              ),
              leading: IconButton(
                icon: Image.asset('assets/images/back_button.png'),
                onPressed: () {
                  Navigator.pop(context); // 이전 화면으로 돌아가기
                },
              ),
            ),
            // 고정된 헤더 영역
            SliverPersistentHeader(
              delegate: SliverAppBarDelegate(
                title: storeName,
                tabBar: TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: '메뉴'),
                    Tab(text: '커뮤니티'),
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        // 본문 영역
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                // businessNumber에 따라 다른 탭을 보여줌
                children: widget.businessNumber == 'whale_pizza'
                    ? [
                        MenuTab(),
                        CommunityTab(),
                      ]
                    : [
                        DefaultTab(),
                        DefaultCommunityTab(),
                      ],
              ),
            ),
          ],
        ),
      ),
      // 탭에 따라 달라지는 플로팅 액션 버튼
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
    );
  }
}

// SliverPersistentHeaderDelegate 클래스 정의
class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({required this.title, required this.tabBar});

  final String title;
  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height + 70.0;
  @override
  double get maxExtent => tabBar.preferredSize.height + 70.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 8.0), // 위쪽 여백 추가
          Text(
            title,
            style: TextStyle(
              fontSize: 30, // 텍스트 크기를 30으로 조절
              fontWeight: FontWeight.bold,
            ),
          ),
          tabBar,
          Container(
            color: Colors.purple,
            height: 4.0,
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return oldDelegate.title != title || oldDelegate.tabBar != tabBar;
  }
}
