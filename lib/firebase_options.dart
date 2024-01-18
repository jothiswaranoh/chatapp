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
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB5SpMQcNUiYql3yCB1gLRs6P8Fr6eM9kE',
    appId: '1:299864826:web:7807e0b6543b60c570ef43',
    messagingSenderId: '299864826',
    projectId: 'jschat-4e493',
    authDomain: 'jschat-4e493.firebaseapp.com',
    databaseURL: 'https://jschat-4e493-default-rtdb.firebaseio.com',
    storageBucket: 'jschat-4e493.appspot.com',
    measurementId: 'G-NVGQ4FWE9T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCRhizMHUqILq7PmGgxhK272HecF2QcfYA',
    appId: '1:299864826:android:53bc2080653fd69e70ef43',
    messagingSenderId: '299864826',
    projectId: 'jschat-4e493',
    databaseURL: 'https://jschat-4e493-default-rtdb.firebaseio.com',
    storageBucket: 'jschat-4e493.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDBgQU-huA0ffkVpyHyjqTQNA4vyiUGRpk',
    appId: '1:299864826:ios:ea0b88df0999849770ef43',
    messagingSenderId: '299864826',
    projectId: 'jschat-4e493',
    databaseURL: 'https://jschat-4e493-default-rtdb.firebaseio.com',
    storageBucket: 'jschat-4e493.appspot.com',
    iosBundleId: 'com.example.groupchat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDBgQU-huA0ffkVpyHyjqTQNA4vyiUGRpk',
    appId: '1:299864826:ios:7c3ec80dc93e8a9b70ef43',
    messagingSenderId: '299864826',
    projectId: 'jschat-4e493',
    databaseURL: 'https://jschat-4e493-default-rtdb.firebaseio.com',
    storageBucket: 'jschat-4e493.appspot.com',
    iosBundleId: 'com.example.groupchat.RunnerTests',
  );
}