//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo
            Image.asset(
              'assets/images/applogo.png', 
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 30.0),

            // App slogan
            const Text(
              'Find It. Report It. Get It Back.',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50.0),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle "Lost Item" button click (e.g., navigate to lost item reporting page)
                  },
                  icon: const Icon(Icons.search, color: Colors.white),
                  label: const Text('Lost an Item'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    minimumSize: const Size(150, 50),
                  ),
                ),
                const SizedBox(width: 20.0),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle "Found Item" button click (e.g., navigate to found item reporting page)
                  },
                  icon: const Icon(Icons.add_box, color: Colors.white),
                  label: const Text('Found an Item'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    minimumSize: const Size(150, 50),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}