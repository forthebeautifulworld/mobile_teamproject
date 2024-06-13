import 'package:flutter/material.dart';
import 'database_helper.dart';

class StoreListPage extends StatefulWidget {
  const StoreListPage({super.key});

  @override
  _StoreListPageState createState() => _StoreListPageState();
}

class _StoreListPageState extends State<StoreListPage> {
  List<Map<String, dynamic>> _stores = []; // 가게 정보를 저장할 리스트

  @override
  void initState() {
    super.initState();
    _loadStores(); // 위젯 초기화 시 가게 정보 로드
  }

  // 데이터베이스에서 가게 정보를 불러오는 메서드
  Future<void> _loadStores() async {
    final stores = await DatabaseHelper().getStores();
    setState(() {
      _stores = stores;
    });
  }

  // 가게를 삭제하는 메서드
  Future<void> _deleteStore(int id) async {
    await DatabaseHelper().deleteStore(id);
    _loadStores(); // 삭제 후 리스트를 새로고침
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Stores:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${_stores.length}', // 총 가게 수 표시
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _stores.length,
              itemBuilder: (context, index) {
                final store = _stores[index];
                return ExpansionTile(
                  title: Text(store['storeName']), // 가게 이름 표시
                  subtitle: Text(store['storeLocation']), // 가게 위치 표시
                  children: [
                    ListTile(
                      title: const Text('Owner Name'),
                      subtitle: Text(store['ownerName']), // 가게 주인 이름 표시
                    ),
                    ListTile(
                      title: const Text('Store Phone'),
                      subtitle: Text(store['storePhone']), // 가게 전화번호 표시
                    ),
                    ListTile(
                      title: const Text('Business Number'),
                      subtitle: Text(store['businessNumber']), // 사업자 번호 표시
                    ),
                    ListTile(
                      title: const Text('Owner Phone'),
                      subtitle: Text(store['ownerPhone']), // 가게 주인 전화번호 표시
                    ),
                    ListTile(
                      title: const Text('Store Type'),
                      subtitle: Text(store['storeType']), // 가게 유형 표시
                    ),
                    ListTile(
                      title: const Text('Average Price'),
                      subtitle: Text(store['avgPrice'].toString()), // 평균 가격 표시
                    ),
                    ListTile(
                      title: const Text('Max Capacity'),
                      subtitle: Text(store['maxCapacity'].toString()), // 최대 수용 인원 표시
                    ),
                    ListTile(
                      title: const Text('Store Features'),
                      subtitle: Text(store['storeFeatures']), // 가게 특징 표시
                    ),
                    ListTile(
                      title: ElevatedButton(
                        onPressed: () => _deleteStore(store['id']), // 가게 삭제 버튼
                        child: const Text('Delete Store'),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}