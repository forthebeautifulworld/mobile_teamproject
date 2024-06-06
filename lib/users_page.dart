//users_page.dart
import 'package:flutter/material.dart';
import 'database_helper.dart'; // DatabaseHelper 임포트

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  Future<List<Map<String, dynamic>>> _fetchUsers() async {
    return await DatabaseHelper().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user['id']),
                  subtitle: Text('Password: ${user['password']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
