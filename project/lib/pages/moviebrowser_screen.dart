import 'package:flutter/material.dart';
import 'package:project/pages/profile_screen.dart';

class MoviebrowserScreen extends StatelessWidget {
  const MoviebrowserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text('Profil'),
            ElevatedButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder:(context) => const ProfileScreen(),));},
              child: Text('Przejdź do zapisanych filmów')),
          ],
        ),
      ),
    );
  }
}