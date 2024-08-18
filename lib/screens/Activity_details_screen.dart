import 'package:flutter/material.dart';

class ActivityDetailsScreen extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;
  final bool isJoinable;

  const ActivityDetailsScreen({
    super.key,
    required this.title,
    required this.imagePath,
    required this.description,
    this.isJoinable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 200,
                color: Colors.grey[300],
                child: const Center(child: Text('Image not found')),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          if (isJoinable)
            Center(
              child: ElevatedButton(
                child: const Text('Join/Register'),
                onPressed: () {
                  // Handle join/register logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Join/Register functionality not implemented')),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
