import 'package:flutter/material.dart';
import 'login_page.dart';
import 'database_helper.dart';
import 'users_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String profileImage = 'assets/default_profile.jpg';
  DateTime? selectedDate;

  void updateProfileImage() {
    setState(() {
      profileImage = 'assets/setting_profile.jpg';
    });
  }

  void signUp() async {
    String name = nameController.text;
    String birth = selectedDate != null
        ? "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}"
        : '';
    String userId = idController.text;
    String password = passwordController.text;

    if (name.isEmpty || birth.isEmpty || userId.isEmpty || password.isEmpty) {
      _showErrorDialog('Please fill all fields');
      return;
    }

    if (!userId.contains('@')) {
      _showErrorDialog('Please enter a valid email address');
      return;
    }

    Map<String, dynamic> user = {
      'name': name,
      'birth': birth,
      'userId': userId,
      'password': password,
    };

    try {
      await DatabaseHelper().insertUser(user);
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      if (!mounted) return;
      _showErrorDialog('Failed to sign up. Please try again.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UsersPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16.0), // 간격 추가
            InkWell(
              onTap: () async {
                final selectedTemp = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (selectedTemp != null) {
                  setState(() {
                    selectedDate = selectedTemp;
                  });
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Birth Date',
                  border: OutlineInputBorder(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate != null
                          ? "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}"
                          : 'Select Date',
                      style: TextStyle(
                        color: selectedDate != null
                            ? Colors.black
                            : Colors.grey[400],
                      ),
                    ),
                    Icon(
                      Icons.calendar_today,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0), // 간격 추가
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: 'User Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: signUp,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}