import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class ActivityProvider with ChangeNotifier {
  final String _baseUrl = "10.10.11.168";

  Future<void> updateActivity(Map<String, dynamic> result) async {
    try {
      var url = Uri.http(_baseUrl, '/flutter/addActivity.php');

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
          "isJoinable": result['isJoinable']?.toString() ?? '0',
        },
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 'success') {
          Fluttertoast.showToast(
            backgroundColor: Colors.green,
            textColor: Colors.white,
            msg: 'Activity updated successfully',
            toastLength: Toast.LENGTH_SHORT,
          );
          notifyListeners(); // Update UI listeners
        } else {
          _showErrorToast(data['message']);
        }
      } else {
        _showErrorToast('Failed to update activity');
      }
    } catch (e) {
      print('Error: $e');
      _showErrorToast('An error occurred. Please try again.');
    }
  }

  Future<void> deleteActivity(String activityId) async {
    try {
      var url = Uri.http(_baseUrl, '/flutter/delActivity.php');

      var response = await http.post(
        url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"id": activityId},
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 'success') {
          Fluttertoast.showToast(
            backgroundColor: Colors.green,
            textColor: Colors.white,
            msg: 'Activity deleted successfully',
            toastLength: Toast.LENGTH_SHORT,
          );
          notifyListeners(); // Update UI listeners
        } else {
          _showErrorToast(data['message']);
        }
      } else {
        _showErrorToast('Failed to delete activity');
      }
    } catch (e) {
      print('Error: $e');
      _showErrorToast('An error occurred. Please try again.');
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      backgroundColor: Colors.red,
      textColor: Colors.white,
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
