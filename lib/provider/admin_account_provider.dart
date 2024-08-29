// provider/admin_account_provider.dart

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminAccountProvider extends ChangeNotifier {
  Map<String, String> accountData = {};
  bool isEditing = false;

  // Load account details from the server
  Future<void> loadAccount(String id) async {
    var url = Uri.parse("http://10.10.11.168/flutter/getAccountManager.php");
    var response = await http.post(url, body: {
      "id": id,
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      accountData = {
        "ID": data['userID'],
        "EMAIL": data['email'],
        "ROLE": data['isAdmin'] == "1" ? "ADMIN" : "STUDENT",
        "StudentID": data['studentId'],
        "PhoneNumber": data['phoneNumber'],
        "password": '', // Ensure the password field is included
      };
      notifyListeners();
    } else {
      throw Exception("Failed to load account data");
    }
  }

  // Toggle editing mode
  void editAccount() {
    isEditing = true;
    notifyListeners();
  }

  // Save account details to the server
  Future<void> saveAccount() async {
    var url = Uri.parse("http://10.10.11.168/flutter/editAccountManager.php");

    var response = await http.post(url, body: {
      "userID": accountData['ID'],
      "phone": accountData['PhoneNumber'],
      "email": accountData['EMAIL'],
      "password": accountData['password'] ?? '',
      "studentId": accountData['StudentID'],
      "isAdmin": accountData['ROLE'] == 'ADMIN' ? '1' : '0',
    });

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);

      if (responseData['status'] == 'success') {
        isEditing = false;
        notifyListeners();
      } else {
        throw Exception('Failed to update account: ${responseData['message']}');
      }
    } else {
      throw Exception('Failed to connect to server');
    }
  }

  // Cancel editing
  void cancelEdit() {
    isEditing = false;
    notifyListeners();
  }

  // Clear account data
  void clearAccountData() {
    accountData.clear();
    notifyListeners();
  }
}
