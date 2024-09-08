// provider/admin_account_provider.dart

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminAccountProvider extends ChangeNotifier {
  Map<String, String> accountData = {};
  bool isEditing = false;

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
