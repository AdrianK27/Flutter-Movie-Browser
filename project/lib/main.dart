import 'package:flutter/material.dart';
import 'package:project/pages/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Browser App',

      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

      home: MainScreen(
        isDark: isDark,
        onThemeChanged: (value) {
          setState(() {
            isDark = value;
          });
        },
      ),
    );
  }
}
