import 'package:flutter/material.dart';
import 'package:new_life/model/users.dart';
import 'package:new_life/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user; //Must be private variable tp prevent bugs
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
