import 'package:flutter/material.dart';
import 'login_page.dart';
import 'database_helper.dart';  // Import the database helper class
import 'users_page.dart';  // Import the users page class

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String profileImage = 'assets/default_profile.jpg';

  void updateProfileImage() {
    setState(() {
      profileImage = 'assets/setting_profile.jpg';
    });
  }

  void signUp() async {
    String name = nameController.text;
    String birth = birthController.text;
    String userId = idController.text;
    String password = passwordController.text;

    if (name.isEmpty || birth.isEmpty || userId.isEmpty || password.isEmpty) {
      _showErrorDialog('Please fill all fields');
      return;
    }

    // Prepare the user data
    Map<String, dynamic> user = {
      'name': name,
      'birth': birth,
      'userId': userId,
      'password': password,
    };

    try {
      // Insert the user data into the database
      await DatabaseHelper().insertUser(user);

      // Navigate to the login page or show success message
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
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
            TextField(
              controller: birthController,
              decoration: const InputDecoration(labelText: 'Birth Date'),
            ),
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: 'User ID'),
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