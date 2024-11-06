// lib/learn/area_rectangle.dart

import 'package:flutter/material.dart';
import 'package:area_and_volume/learn/area_page.dart'; // Import AreaPage for navigation
import 'package:area_and_volume/introduction_page.dart'; // Import IntroductionPage for navigation

class AreaRectanglePage extends StatelessWidget {
  const AreaRectanglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.black, size: 30),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => IntroductionPage(
                  localizedStrings: {
                    'title': 'Area and Volume',
                    'learn': 'Learn',
                    'practice': 'Practice',
                    'play': 'Play',
                    'learn_title': 'Learn - Select topic',
                    'area': 'Area',
                    'volume': 'Volume',
                  },
                  changeLanguage:
                      () {}, // Placeholder, implement actual function
                ),
              ),
            ); // Navigate to IntroductionPage
          },
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Text Centered
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Area of a Rectangle',
                    style: TextStyle(
                      fontSize: 36, // Increased font size for the title
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center, // Center align title text
                  ),
                ),
                const SizedBox(height: 30),

                // Descriptive Text
                const Text(
                  '• If you are measuring the area of a rectangle, then the area will equal the length multiplied by the width\n'
                  '• Area of a rectangle = length x width\n'
                  '• We can also write this as A = l x w or A = lw, where A is the area, l is the length and w is the width\n'
                  '• The area of the rectangle below is 5 x 3 = 15 squares',
                  style: TextStyle(
                    fontSize: 24, // Font size for descriptive text
                    color: Colors.black,
                    height: 1.5, // Line height for better readability
                  ),
                  textAlign:
                      TextAlign.center, // Left align text within the container
                ),
                const SizedBox(height: 30),

                // Image to Demonstrate Area Calculation
                Center(
                  child: Image.asset(
                    'assets/images/area_rectangle.png', // Replace with the correct path to your image asset
                    width: 600, // Width for the image
                    height: 350, // Height for the image
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const AreaPage()), // Navigate back to AreaPage
                );
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
                // Add functionality to navigate to next content or slide
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
