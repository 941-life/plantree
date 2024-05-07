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
    apiKey: 'AIzaSyBw_QPZnSVzdlMqjPIUUpGYAX8i1P3BGq4',
    appId: '1:156811341983:web:ce0cc856f921804a7932aa',
    messagingSenderId: '156811341983',
    projectId: 'projecta-ff733',
    authDomain: 'projecta-ff733.firebaseapp.com',
    storageBucket: 'projecta-ff733.appspot.com',
    measurementId: 'G-81KV8L89K7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAMAmx8_97uhRC7d1VAIkMq1ad9tw3tN44',
    appId: '1:156811341983:android:80aca2188d81e51b7932aa',
    messagingSenderId: '156811341983',
    projectId: 'projecta-ff733',
    storageBucket: 'projecta-ff733.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBlzgJvi5AGOBNsMwNaK85vUGMJYpsOyqU',
    appId: '1:156811341983:ios:3bd18522244c0cfd7932aa',
    messagingSenderId: '156811341983',
    projectId: 'projecta-ff733',
    storageBucket: 'projecta-ff733.appspot.com',
    iosBundleId: 'com.example.projecta',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBlzgJvi5AGOBNsMwNaK85vUGMJYpsOyqU',
    appId: '1:156811341983:ios:26ebd7221d93240d7932aa',
    messagingSenderId: '156811341983',
    projectId: 'projecta-ff733',
    storageBucket: 'projecta-ff733.appspot.com',
    iosBundleId: 'com.example.projecta.RunnerTests',
  );
}