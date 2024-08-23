import 'package:flutter/material.dart';
import 'add_activity_screen.dart'; // Import your AddActivityScreen
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ActivityDetailsArguments {
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

    Future<void> _editActivity() async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddActivityScreen(
            activityId: args.activityId,
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

      if (result != null) {
        try {
          var url = Uri.http("10.10.11.168", '/flutter/addActivity.php');

          var response = await http.post(
            url,
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
            body: {
              "id": result['activityId']?.toString() ?? '',  
              "title": result['title'] ?? 'Null',
              "imagePath": result['imagePath'] ?? 'Null',
              "description": result['description'] ?? 'Null',
              "scoreType": result['category'] ?? 'Null',
              "score": result['score']?.toString() ?? '0',
              "location": result['location']?.toString() ?? '0',
              "datetime": result['datetime']?.toString() ?? '0',
              "isJoinable" : result['isJoinable']?.toString() ?? '0',
            }
          );

          if (response.statusCode == 200) {
            var data = json.decode(response.body);
            if (data['status'] == 'success') {
              Fluttertoast.showToast(
                backgroundColor: Colors.green,
                textColor: Colors.white,
                msg: 'Activity updated successfully',
                toastLength: Toast.LENGTH_SHORT,
              );
            } else {
              Fluttertoast.showToast(
                backgroundColor: Colors.red,
                textColor: Colors.white,
                msg: data['message'],
                toastLength: Toast.LENGTH_SHORT,
              );
            }
          } else {
            throw Exception('Failed to update activity');
          }
        } catch (e) {
          print('Error: $e');
          Fluttertoast.showToast(
            backgroundColor: Colors.red,
            textColor: Colors.white,
            msg: 'An error occurred. Please try again.',
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      }
      Navigator.pop(context);
    }

    Future<void> _deleteActivity() async {
      try {
        var url = Uri.http("10.10.11.168", '/flutter/delActivity.php');

        var response = await http.post(
          url,
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
          body: {
            "id": args.activityId,
          }
        );

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          if (data['status'] == 'success') {
            Fluttertoast.showToast(
              backgroundColor: Colors.green,
              textColor: Colors.white,
              msg: 'Activity deleted successfully',
              toastLength: Toast.LENGTH_SHORT,
            );
            Navigator.pop(context); // Go back after deletion
          } else {
            Fluttertoast.showToast(
              backgroundColor: Colors.red,
              textColor: Colors.white,
              msg: data['message'],
              toastLength: Toast.LENGTH_SHORT,
            );
          }
        } else {
          throw Exception('Failed to delete activity');
        }
      } catch (e) {
        print('Error: $e');
        Fluttertoast.showToast(
          backgroundColor: Colors.red,
          textColor: Colors.white,
          msg: 'An error occurred. Please try again.',
          toastLength: Toast.LENGTH_SHORT,
        );
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
      floatingActionButton: FloatingActionButton(
        onPressed: _deleteActivity,
        child: const Icon(Icons.delete),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
