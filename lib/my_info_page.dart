import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'login_page.dart';

class MyInfoPage extends StatelessWidget {
  final Map<String, dynamic> userInfo;

  const MyInfoPage({Key? key, required this.userInfo}) : super(key: key);

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('회원 탈퇴'),
          content: const Text('정말로 회원 탈퇴하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('탈퇴'),
              onPressed: () {
                _deleteUser(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteUser(BuildContext context) async {
    await DatabaseHelper().deleteUser(userInfo['id']);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
    );
  }

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
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showDeleteConfirmationDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('회원 탈퇴'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}