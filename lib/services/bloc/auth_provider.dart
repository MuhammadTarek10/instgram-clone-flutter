import 'dart:typed_data';

import 'package:instgramclone/services/bloc/auth_user.dart';
import 'package:instgramclone/models/user.dart' as model;

abstract class AuthProvider {
  Future<void> initialize();
  AuthUser? get currentUser;
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  Future<model.User> getUserDetails();

  Future<AuthUser> createUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List? file,
  });
  Future<void> logOut();
  Future<void> sendEmailVerification();
  Future<void> sendPasswordReset({required String toEmail});
}
