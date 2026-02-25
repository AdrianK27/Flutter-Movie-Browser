import 'package:flutter/material.dart';
import 'package:project/pages/moviebrowser_screen.dart';
import 'package:project/pages/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text('Aplikacja do przeglądania filmów'),
            ElevatedButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder:(context) => const ProfileScreen(),));},
              child: Text('Przejdź do zapisanych filmów')),
              ElevatedButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder:(context) => const MoviebrowserScreen(),));},
              child: Text('Przejdź do przeglądania filmów'))
          ],
        ),
      ),
    );
  }
}