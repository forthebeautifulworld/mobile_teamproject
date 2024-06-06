import 'package:flutter/material.dart';
import 'database_helper.dart';

class StoreListPage extends StatefulWidget {
  const StoreListPage({super.key});

  @override
  _StoreListPageState createState() => _StoreListPageState();
}

class _StoreListPageState extends State<StoreListPage> {
  List<Map<String, dynamic>> _stores = [];

  @override
  void initState() {
    super.initState();
    _loadStores();
  }

  Future<void> _loadStores() async {
    final stores = await DatabaseHelper().getStores();
    setState(() {
      _stores = stores;
    });
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
                  '${_stores.length}',
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
                  title: Text(store['storeName']),
                  subtitle: Text(store['storeLocation']),
                  children: [
                    ListTile(
                      title: const Text('Owner Name'),
                      subtitle: Text(store['ownerName']),
                    ),
                    ListTile(
                      title: const Text('Store Phone'),
                      subtitle: Text(store['storePhone']),
                    ),
                    ListTile(
                      title: const Text('Business Number'),
                      subtitle: Text(store['businessNumber']),
                    ),
                    ListTile(
                      title: const Text('Owner Phone'),
                      subtitle: Text(store['ownerPhone']),
                    ),
                    ListTile(
                      title: const Text('Store Type'),
                      subtitle: Text(store['storeType']),
                    ),
                    ListTile(
                      title: const Text('Average Price'),
                      subtitle: Text(store['avgPrice'].toString()),
                    ),
                    ListTile(
                      title: const Text('Max Capacity'),
                      subtitle: Text(store['maxCapacity'].toString()),
                    ),
                    ListTile(
                      title: const Text('Store Features'),
                      subtitle: Text(store['storeFeatures']),
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