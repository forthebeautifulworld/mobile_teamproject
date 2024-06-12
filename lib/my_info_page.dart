import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'login_page.dart';

class MyInfoPage extends StatelessWidget {
  final Map<String, dynamic> userInfo; // 사용자 정보를 저장하는 변수

  const MyInfoPage({Key? key, required this.userInfo}) : super(key: key);

  // 회원 탈퇴 확인 다이얼로그를 표시하는 메서드
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
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
            TextButton(
              child: const Text('탈퇴'),
              onPressed: () {
                _deleteUser(context); // 회원 탈퇴 처리
              },
            ),
          ],
        );
      },
    );
  }

  // 회원 탈퇴 처리 메서드
  void _deleteUser(BuildContext context) async {
    await DatabaseHelper().deleteUser(userInfo['id']); // 데이터베이스에서 사용자 정보 삭제
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()), // 로그인 페이지로 이동
          (route) => false, // 이전 페이지로 돌아갈 수 없도록 설정
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
                backgroundImage: AssetImage('assets/images/default_profile.jpeg'), // 기본 프로필 이미지
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Name: ${userInfo['name']}', // 사용자 이름 표시
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
              subtitle: Text('${userInfo['userId']}'), // 사용자 ID 표시
            ),
            ListTile(
              leading: const Icon(Icons.cake),
              title: const Text('Birth'),
              subtitle: Text('${userInfo['birth']}'), // 사용자 생년월일 표시
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Password'),
              subtitle: Text('${userInfo['password']}'), // 사용자 비밀번호 표시
            ),
            const Spacer(), // 남은 공간을 차지하는 빈 공간
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showDeleteConfirmationDialog(context); // 회원 탈퇴 확인 다이얼로그 표시
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