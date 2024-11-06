// lib/introduction_page.dart

import 'package:flutter/material.dart';
import './app_localizations.dart';

class IntroductionPage extends StatelessWidget {
  final Map<String, String> localizedStrings;
  final VoidCallback changeLanguage;

  const IntroductionPage({
    super.key,
    required this.localizedStrings,
    required this.changeLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                Text(
                  localizedStrings['title'] ?? 'Loading...',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                _buildButton(context, localizedStrings['learn'] ?? 'Learn',
                    Colors.pink, '/learn'),
                const SizedBox(height: 30),
                _buildButton(
                    context,
                    localizedStrings['practice'] ?? 'Practice',
                    Colors.green,
                    '/practice'),
                const SizedBox(height: 30),
                _buildButton(context, localizedStrings['play'] ?? 'Play',
                    Colors.blue, '/play'),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Switch(
                value: Localizations.localeOf(context).languageCode == 'es',
                onChanged: (bool value) {
                  changeLanguage();
                },
                activeColor: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String text, Color color, String route) {
    return SizedBox(
      width: 300,
      height: 70,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
