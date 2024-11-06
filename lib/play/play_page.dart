// lib/play/play_page.dart

import 'package:flutter/material.dart';
import 'package:area_and_volume/play/shape_filler_page.dart'; // Import the game page

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play Games'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildGameBlock(
              context,
              'Paint the Wall!', // Game name
              'Paint a wall for an art festival.', // Short description
              '/shapeFiller', // Route for the game page
            ),
            // Add more games as blocks in the future
          ],
        ),
      ),
    );
  }

  Widget _buildGameBlock(BuildContext context, String title, String description, String route) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        title: Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward, color: Colors.blue),
        onTap: () {
          Navigator.pushNamed(context, route); // Navigate to game page
        },
      ),
    );
  }
}
