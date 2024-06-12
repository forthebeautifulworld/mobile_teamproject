import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'home_page.dart';
import 'pages/restaurant_page.dart';

class StoreSearchPage extends StatefulWidget {
  const StoreSearchPage({super.key});

  @override
  _StoreSearchPageState createState() => _StoreSearchPageState();
}

class _StoreSearchPageState extends State<StoreSearchPage> {
  int nrow = 0;
  List<String> storeNames = [];

  final List<Map<String, int>> locations = [
    {"left": 50, "top": 100},
    {"left": 150, "top": 200},
    {"left": 250, "top": 300},
    {"left": 350, "top": 400},
    // 필요한 만큼 위치를 추가
  ];

  @override
  void initState() {
    super.initState();
    _fetchStoreData();
  }

  Future<void> _fetchStoreData() async {
    final count = await DatabaseHelper().getStoreCount();
    final names = await DatabaseHelper().getStoreNames();
    setState(() {
      nrow = count;
      storeNames = names;
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
                builder: (context) => RestaurantPage(storeName: '고래한입피자 단국대점'),
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
                builder: (context) => RestaurantPage(storeName: storeNames[i]),
              ),
            );
          },
        ),
      ));
    }
    return markers;
  }

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
          Positioned.fill(
            child: Image.asset(
              'assets/images/map.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          ..._buildMarkers(),
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
                builder: (context) => const HomePage(userInfo: {}),
              ),
            );
          }
          // 다른 탭을 클릭했을 때의 로직 추가 가능
        },
      ),
    );
  }
}
