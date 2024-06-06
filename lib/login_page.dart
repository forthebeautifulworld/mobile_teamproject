import 'package:flutter/material.dart';
import 'home_page.dart';
import 'signup_page.dart'; // 회원가입 페이지로 이동하도록 import 추가
import 'database_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signIn() async{
    // 여기에 실제 로그인 로직을 추가하세요 (ex. Firebase Auth)
    String email = emailController.text;
    String password = passwordController.text;

    // 데이터베이스에서 사용자 정보를 가져옵니다.
    List<Map<String, dynamic>> users = await DatabaseHelper().getUsers();

    // 입력한 email과 password가 데이터베이스에 존재하는지 확인합니다.
    bool userExists = users.any((user) => user['userId'] == email && user['password'] == password);

    if (userExists) {
      // 로그인 성공 시 my_app3로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // 로그인 실패 시 경고 메시지
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid email or password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/fork_background.png'), // 포크 배경 이미지
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Login",
                    style:
                    TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {}, // 아이디 찾기 기능 추가 가능
                        child: const Text("아이디 찾기"),
                      ),
                      TextButton(
                        onPressed: () {}, // 비밀번호 찾기 기능 추가 가능
                        child: const Text("비밀번호 찾기"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: signIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: const Text("Sign In"),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Center(child: Text("Or")),
                  const SizedBox(height: 16.0),
                  OutlinedButton(
                    onPressed: () {
                      // 회원가입 페이지로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupPage()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text("Sign up"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


