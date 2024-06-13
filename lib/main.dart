// 앱의 메인 파일
import 'package:flutter/material.dart';
import 'login_page.dart'; // 로그인 페이지 import

void main() {
  runApp(const MyApp()); // 앱 실행
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Reservation App', // 앱 제목
      theme: ThemeData(
        primarySwatch: Colors.purple, // 앱 테마 색상
      ),
      home: const InitialPage(), // 초기 페이지 설정
    );
  }
}

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()), // 탭하면 로그인 페이지로 이동
        );
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'assets/images/initial_page_image.png', // 초기 페이지 이미지 경로
            fit: BoxFit.cover, // 이미지 채우기 모드
            width: double.infinity, // 이미지 가로 크기를 화면에 맞춤
            height: double.infinity, // 이미지 세로 크기를 화면에 맞춤
          ),
        ),
      ),
    );
  }
}