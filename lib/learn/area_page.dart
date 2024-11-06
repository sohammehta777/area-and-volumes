// lib/area_page.dart

import 'package:flutter/material.dart';
import './area_rectangle.dart';
import './area_page.dart';

class AreaPage extends StatelessWidget {
  const AreaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.black, size: 30),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center align all children
              children: [
                // Title Text Centered
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'What is Area?',
                    style: TextStyle(
                      fontSize: 36, // Increased font size for the title
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center, // Center align text
                  ),
                ),
                const SizedBox(height: 30),

                // Bulleted List Centered
                const Center(
                  child: Text(
                    '• Area is the amount of space that is inside a shape.\n'
                    '• Because it is an amount of space, it has to be measured in squares.\n'
                    '• Centimeter (cm) is a unit used to measure length or distance. Example, the side of a square could be 5 cm long.\n'
                    '• If the shape is measured in Centimeter (cm), then the area would be measured in square cm or cm² (square centimeter or centimeter square).',
                    style: TextStyle(
                      fontSize: 24, // Font size less than the title
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center, // Center align text
                  ),
                ),
                const SizedBox(height: 30),

                // Increased Image Size
                Center(
                  child: Image.asset(
                    'assets/images/area_example.png', // Replace with the correct path to your image asset
                    width: 600, // Increased width for the image
                    height: 350, // Increased height for the image
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),

          // Align the left arrow button at the center left
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  size: 30, color: Colors.black),
              onPressed: () {
                // Add functionality to navigate to previous content or slide
              },
            ),
          ),

          // Align the right arrow button at the center right
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios,
                  size: 30, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AreaRectanglePage()),
                );
              },
            ),
          ),

          // Align the toggle switch at the bottom-right corner
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Switch(
                value: Localizations.localeOf(context).languageCode == 'es',
                onChanged: (bool value) {
                  // Implement language change functionality
                },
                activeColor: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
