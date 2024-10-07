import 'package:flutter/material.dart';

class User {
  final String? id;
  final String? name;
  final String? roles;
  final String? userName;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? avata;
  final String? token;

  User({
    required this.id,
    this.name,
    this.roles,
    this.userName,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.avata,
    this.token
  });
}

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User? user) {
    print("user trong provided");
    print(user?.firstName);
    print(user?.token);
    _user = user;
    notifyListeners();
  }
}
