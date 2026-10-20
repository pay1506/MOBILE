import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.blue.shade50,
              child: const Icon(
                Icons.person,
                size: 55,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pengguna TokoKita',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Selamat datang di TokoKita!'),
          ],
        ),
      ),
    );
  }
}