import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDark;
  final Function(bool) onThemeChanged;

  const SettingsScreen({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Text('Settings'),
            Row(
              children: [
                Text('set the dark mode'),
                Switch(
                  value: widget.isDark,
                  onChanged: (value) {
                  widget.onThemeChanged(value);
                  setState(() {});
              },
            ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
