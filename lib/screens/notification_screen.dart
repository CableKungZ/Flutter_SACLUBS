import 'package:flutter/material.dart';
import 'activity_details_screen.dart'; 
import 'add_activity_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'search_screen.dart';
import 'profile_screen.dart';
import 'homepage_screen.dart';
import 'profile_screen.dart';



class NotiScreen extends StatefulWidget {
  final String userID;

  const NotiScreen({
    super.key,
    required this.userID,
  });

  @override
  _NotiScreen createState() => _NotiScreen();
}

class _NotiScreen extends State<NotiScreen> {
  int _selectedIndex = 2;

  String? _studentId;
  String? _isAdmin;
  String? _phoneNumber;
  String? _userId;
  String? _email;

  @override
  void initState() {
    super.initState();
    getAccount();
  }

  Future<void> getAccount() async {
    try {
      var url = Uri.http("10.10.11.168", '/flutter/getAccount.php');
      var response = await http.post(url, body: {
        "userID": widget.userID,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            _studentId = data['studentId'];
            _isAdmin = data['isAdmin'];
            _phoneNumber = data['phoneNumber'];
            _email = data['email'];
            _userId = data['userId'];
          });
        } else {
          Fluttertoast.showToast(
            backgroundColor: Colors.red,
            textColor: Colors.white,
            msg: data['message'],
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      } else {
        throw Exception('Failed to load account');
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
          builder: (context) => StudentInfoCard(userID: userID),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hide back button
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
                _studentId ?? 'Loading...',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey[200], // Light grey background color
        child: ListView(
          children: const [
            EventCard(
              title: 'เข้าร่วมเชียร์',
              remaining: 'เหลือระยะเวลาอีก 1 วัน 20 ชั่วโมง 20 นาที ก่อนเริ่มกิจกรรม',
            ),

          ],
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
  final String remaining;

  const EventCard({
    super.key,
    required this.title,
    required this.remaining,
  });

  @override
  Widget build(BuildContext context) {
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
                Text(remaining, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
