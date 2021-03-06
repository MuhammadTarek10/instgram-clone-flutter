// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB--10cAyRLhmqs-uDQ3quBmKOTbECRrOw',
    appId: '1:405817519307:web:e3f99c33daf3e69501bf4e',
    messagingSenderId: '405817519307',
    projectId: 'instgram-clone-flutter',
    authDomain: 'instgram-clone-flutter.firebaseapp.com',
    storageBucket: 'instgram-clone-flutter.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCj87mOxG7dtSQq_HN6WlsdcQoQsknrylo',
    appId: '1:405817519307:android:e43912e73f8d74fb01bf4e',
    messagingSenderId: '405817519307',
    projectId: 'instgram-clone-flutter',
    storageBucket: 'instgram-clone-flutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyChFrMhAd4gxlOzf8nqu4lIxOe13LpxORY',
    appId: '1:405817519307:ios:d143c91e1b92e2d101bf4e',
    messagingSenderId: '405817519307',
    projectId: 'instgram-clone-flutter',
    storageBucket: 'instgram-clone-flutter.appspot.com',
    iosClientId: '405817519307-ko9tt2cg5f33levhtgd1toiudkrlf9d4.apps.googleusercontent.com',
    iosBundleId: 'course.flutter.instgramclone',
  );
}
