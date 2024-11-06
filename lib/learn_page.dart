// lib/learn_page.dart

import 'package:flutter/material.dart';
import 'package:area_and_volume/app_localizations.dart';
import 'package:area_and_volume/learn/area_page.dart'; // Import AreaPage
import 'package:area_and_volume/learn/volume_page.dart'; // Import VolumePage

class LearnPage extends StatelessWidget {
  const LearnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.home, size: 30), // Increased icon size
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.translate('learn_select_topic') ??
              'Learn - Select Topic',
          style: const TextStyle(
              fontSize: 30), // Increased font size for the AppBar title
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0, // Optional: Remove the shadow under the AppBar
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(context, 'area', Colors.purple, '/area'),
                const SizedBox(height: 30),
                _buildButton(context, 'volume', Colors.blue, '/volume'),
              ],
            ),
          ),
          // Align the toggle switch at the bottom-right corner
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Adjust padding as needed
              child: Switch(
                value: Localizations.localeOf(context).languageCode == 'es',
                onChanged: (bool value) {
                  String newLocale = value ? 'es' : 'en';
                  Navigator.of(context).pushReplacementNamed('/');
                  // Implement changing the locale here
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
      BuildContext context, String textKey, Color color, String route) {
    return SizedBox(
      width: 300, // Increased width for the button
      height: 70, // Increased height for the button
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(
              context, route); // Navigate to the specified route
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          AppLocalizations.of(context)!.translate(textKey) ?? textKey,
          style: const TextStyle(
            fontSize: 24, // Increased font size for button text
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
