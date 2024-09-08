import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_activity_screen.dart'; // Import your AddActivityScreen
import '/provider/databaseProvider.dart'; // Import your provider
import 'dart:convert';
import 'package:http/http.dart' as http; // Import http package for making requests

class ActivityDetailsArguments {
  final String userId;
  final String activityId;
  final String title;
  final String imagePath;
  final String description;
  final bool isJoinable;
  final String category;
  final String score;
  final String datetime;
  final String location;

  ActivityDetailsArguments({
    required this.userId,
    required this.activityId,
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

    final bool joined = 

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
                onPressed: {
                  await Provider.of<ActivityProvider>().addUserActivity(args.userId,args.activityId);
                },
                child: const Text(if joined ? 'Cancle' : 'Join/Register'),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _deleteActivity,
        child: const Icon(Icons.delete),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
