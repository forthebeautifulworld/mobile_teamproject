import 'package:flutter/material.dart';
import '../tabs/menu_tab.dart';
import '../tabs/community_tab.dart';
import '../pages/reservation_page.dart';
import '../database_helper.dart';

class RestaurantPage extends StatefulWidget {
  final String businessNumber;

  const RestaurantPage({Key? key, required this.businessNumber}) : super(key: key);

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String storeName = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    _fetchStoreName();
  }

  Future<void> _fetchStoreName() async {
    if(widget.businessNumber == 'whale_pizza'){
      setState(() {
        storeName = '고래피자 죽전점';
      });
    }
    else {
      String name = await DatabaseHelper().getStoreNameByBusinessNumber(widget.businessNumber);
      setState(() {
        storeName = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/images/top_pizza_image.png',
                  fit: BoxFit.cover,
                ),
              ),
              leading: IconButton(
                icon: Image.asset('assets/images/back_button.png'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
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
        body: TabBarView(
          controller: _tabController,
          children: [
            MenuTab(),
            CommunityTab(),
          ],
        ),
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
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({required this.title, required this.tabBar});

  final String title;
  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height + 40.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
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
