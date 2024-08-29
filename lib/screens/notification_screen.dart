import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/screens/homepage_screen.dart';
import '/screens/search_screen.dart';
import '/screens/profile_screen.dart';
import 'package:intl/intl.dart';

class NotiScreen extends StatefulWidget {
  final String userID;

  const NotiScreen({
    super.key,
    required this.userID,
  });

  @override
  _NotiScreenState createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  int _selectedIndex = 2;
  List<dynamic> _activities = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserActivities();
  }

  Future<void> fetchUserActivities() async {
    if (_isLoading) {
      setState(() {
        _isLoading = false;
      });

      try {
        var url = Uri.http("10.10.11.168", '/flutter/getUserActivities.php');
        var response = await http.post(url, body: {
          "userID": widget.userID,
        });

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          if (data['status'] == 'success') {
            setState(() {
              _activities = (data['activities'] as List<dynamic>?)?.map((activity) {
                DateTime eventDateTime = DateTime.tryParse(activity['datetime'] ?? '') ?? DateTime.now();
                return {
                  ...activity,
                  'eventDateTime': eventDateTime.toIso8601String(),
                };
              }).toList() ?? [];
            });
          } else {
            Fluttertoast.showToast(
              backgroundColor: Colors.red,
              textColor: Colors.white,
              msg: data['message'] ?? 'Unknown error occurred',
              toastLength: Toast.LENGTH_SHORT,
            );
          }
        } else {
          throw Exception('Failed to load user activities');
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
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    String userID = widget.userID;

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(userID: userID),
          ),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SearchScreen(userID: userID),
          ),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NotiScreen(userID: userID),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(userID: userID),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.grey),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Notifications',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _activities.isEmpty
                ? Center(child: Text('No activities found'))
                : ListView.builder(
                    itemCount: _activities.length,
                    itemBuilder: (context, index) {
                      final activity = _activities[index];
                      final DateTime eventDateTime = DateTime.parse(activity['eventDateTime'] ?? DateTime.now().toString());
                      final String title = activity['title'] ?? 'No title';

                      return EventCard(
                        title: title,
                        eventDateTime: eventDateTime,
                      );
                    },
                  ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
class EventCard extends StatelessWidget {
  final String title;
  final DateTime eventDateTime;

  const EventCard({
    super.key,
    required this.title,
    required this.eventDateTime,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final difference = eventDateTime.difference(now);

    String message;
    Color color;

    if (difference.isNegative) {
      message = 'กิจกรรมจบแล้ว'; // Activity has ended
      color = Colors.red;
    } else if (difference.inDays == 0 && difference.inHours < 24) {
      message = 'กิจกรรมกำลังเริ่มขึ้น'; // Activity is starting soon
      color = Colors.yellow;
    } else {
      message = 'กิจกรรมจะเริ่มในอีก ${difference.inDays} วัน'; // Activity starts in X days
      color = Colors.green;
    }

    return Card(
      margin: const EdgeInsets.all(8),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.red),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(fontSize: 14, color: color),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
