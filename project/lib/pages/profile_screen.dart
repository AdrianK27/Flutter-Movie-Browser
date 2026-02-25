import 'package:flutter/material.dart';
import 'package:project/pages/moviebrowser_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text('Profil'),
            ElevatedButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder:(context) => const MoviebrowserScreen(),));},
              child: Text('Przejdź do przeglądania filmów')),
          ],
        ),
      ),
    );
  }
}