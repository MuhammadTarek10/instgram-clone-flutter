import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instgramclone/exceptions/auth_exceptions.dart';
import 'package:instgramclone/firebase_options.dart';
import 'package:instgramclone/services/storage/storage_service.dart';
import 'auth_user.dart';
import 'auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException, UserCredential;
import 'package:instgramclone/models/user.dart' as model;

class FirebaseAuthProvider implements AuthProvider {
  final _storage = StorageService.firebase();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<AuthUser> createUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List? file}) async {
    try {
      final userCredintials =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        final photoUrl = await _storage.uploadImage(
          userCredintials.user!.uid,
          file,
          'profilePics',
          false,
        );

        model.User _user = model.User(
            username: username,
            uid: userCredintials.user!.uid,
            photoUrl: photoUrl,
            email: email,
            bio: bio,
            followers: [],
            following: []);

        await _firestore
            .collection('users')
            .doc(userCredintials.user!.uid)
            .set(_user.toJson());
        return user;
      } else {
        throw UserNotLoggedInException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyExistedException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else if (e.code == 'user-not-found') {
        throw UserNotFoundException();
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logOut() async {
    final user = currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInException();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInException();
    }
  }

  @override
  Future<void> sendPasswordReset({required String toEmail}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: toEmail);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'firebase_auth/invalid-email':
          throw InvalidEmailAuthException();
        case 'fireabase_auth/user-not-found':
          throw UserNotFoundException();
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }
}
