// lib/learn/volume_page.dart

import 'package:flutter/material.dart';

class VolumePage extends StatelessWidget {
  const VolumePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.black, size: 30),
          onPressed: () {
            Navigator.of(context).pop(); // Go back to the previous screen
          },
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 32.0), // Adjusted padding for horizontal alignment
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align all children to the start
              children: [
                // Title Text Centered
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'WHAT IS VOLUME?',
                    style: TextStyle(
                      fontSize: 36, // Increased font size for the title
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center, // Center align title text
                  ),
                ),
                const SizedBox(height: 50),

                // Descriptive Text with Align for precise positioning
                Align(
                  alignment:
                      Alignment.center, // Center align the text container
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left:
                            20.0), // Adjusted padding for more central alignment
                    child: const Text(
                      '• Every three-dimensional object occupies some space. This space is measured in terms of its volume.\n\n'
                      '• Volume is defined as the space occupied within the boundaries of an object in three-dimensional space.\n\n'
                      '• It is also known as the capacity of the object.\n\n'
                      '• Finding the volume of an object can help us to determine the amount required to fill that object.\n\n'
                      '• For example - The amount of water needed to fill a bottle, an aquarium, or a water tank.\n\n'
                      '• Since different three-dimensional objects have different shapes, their volumes are also variable.',
                      style: TextStyle(
                        fontSize: 25, // Font size for descriptive text
                        color: Colors.black,
                        height: 1.5, // Line height for better readability
                      ),
                      textAlign: TextAlign
                          .left, // Left align text within the container
                    ),
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
                Navigator.of(context)
                    .pop(); // Navigate back to the previous page
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
