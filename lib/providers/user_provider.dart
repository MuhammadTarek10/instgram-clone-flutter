import 'package:flutter/material.dart';
import 'package:instgramclone/models/user.dart';
import 'package:instgramclone/services/bloc/auth_provider.dart';
import 'package:instgramclone/services/bloc/firebase_auth_provider.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  AuthProvider provider = FirebaseAuthProvider();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await provider.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
