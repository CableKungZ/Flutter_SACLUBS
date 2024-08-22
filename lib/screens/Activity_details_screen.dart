import 'package:flutter/material.dart';
import 'add_activity_screen.dart'; // Import your AddActivityScreen


class ActivityDetailsArguments {
  final String title;
  final String imagePath;
  final String description;
  final bool isJoinable;
  final String category;
  final String score;
  final String datetime;
  final String location;

  ActivityDetailsArguments({
    required this.title,
    required this.imagePath,
    required this.description,
    required this.isJoinable,
    required this.category,
    required this.score, 
    required this.datetime, 
    required this.location,
  });
}

class ActivityDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ActivityDetailsArguments args = ModalRoute.of(context)!.settings.arguments as ActivityDetailsArguments;

    Future<void> _editActivity() async {
      final updatedActivity = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddActivityScreen(
            title: args.title,
            imagePath: args.imagePath,
            description: args.description,
            isJoinable: args.isJoinable,
            category: args.category,
            score: args.score,
            datetime: args.datetime,
            location: args.location,
          ),
        ),
      ) as Map<String, dynamic>?;

      if (updatedActivity != null) {
        Navigator.pop(context, updatedActivity);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _editActivity,
          ),
        ],
      ),
      body: ListView(
        children: [
          Image.network(
            args.imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: const Center(child: Text('Image not found')),
              );
            },
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  args.title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  args.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  "วันเวลา เริ่มกิจกรรม : ${args.datetime}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  "สถานที่จัดกิจกรรม : ${args.location}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                if (args.category != "ไม่มี")
                  Text(
                    "เมื่อเข้าร่วม จะได้รับ ${args.category} ${args.score} คะแนน",
                    style: const TextStyle(fontSize: 16),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (args.isJoinable)
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Join/Register functionality not implemented')),
                  );
                },
                child: const Text('Join/Register'),
              ),
            ),
        ],
      ),
    );
  }
}
