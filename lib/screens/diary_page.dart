import 'package:flutter/material.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Diary',
          style: TextStyle(
            color: Colors.white, // White text color
            fontSize: 20, // Adjust font size if needed
            fontWeight: FontWeight.bold, // Optional: Makes text bold
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: const Color.fromRGBO(34, 39, 38, 255),
      body: Container(
        color: const Color.fromRGBO(34, 39, 38, 255), // Ensure the background color is set
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Diary Entries',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Example item count
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(53, 56, 58, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Diary Entry ${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}