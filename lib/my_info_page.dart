import 'package:flutter/material.dart';

class MyInfoPage extends StatelessWidget {
  final Map<String, dynamic> userInfo;

  const MyInfoPage({Key? key, required this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Info'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/default_profile.jpeg'),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Name: ${userInfo['name']}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'User Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('ID'),
              subtitle: Text('${userInfo['userId']}'),
            ),
            ListTile(
              leading: const Icon(Icons.cake),
              title: const Text('Birth'),
              subtitle: Text('${userInfo['birth']}'),
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Password'),
              subtitle: Text('${userInfo['password']}'),
            ),
          ],
        ),
      ),
    );
  }
}