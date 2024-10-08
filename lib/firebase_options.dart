// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCJNVIbvTYqXI0RukEirgE_y8lTJR_H8vM',
    appId: '1:567707333810:web:a76e623839397d4611c5ab',
    messagingSenderId: '567707333810',
    projectId: 'creama-flutter',
    authDomain: 'creama-flutter.firebaseapp.com',
    storageBucket: 'creama-flutter.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAb1kGmkqHYzpMVRB6w8VmN_5f-Ucj9gW4',
    appId: '1:567707333810:android:6762b5fd5dde94cd11c5ab',
    messagingSenderId: '567707333810',
    projectId: 'creama-flutter',
    storageBucket: 'creama-flutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBp0RYgkNPjipRp-zwetpjBmX9EoXlM6P8',
    appId: '1:567707333810:ios:cbeb088e6a1541f811c5ab',
    messagingSenderId: '567707333810',
    projectId: 'creama-flutter',
    storageBucket: 'creama-flutter.appspot.com',
    iosBundleId: 'com.example.creama',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBp0RYgkNPjipRp-zwetpjBmX9EoXlM6P8',
    appId: '1:567707333810:ios:cbeb088e6a1541f811c5ab',
    messagingSenderId: '567707333810',
    projectId: 'creama-flutter',
    storageBucket: 'creama-flutter.appspot.com',
    iosBundleId: 'com.example.creama',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCJNVIbvTYqXI0RukEirgE_y8lTJR_H8vM',
    appId: '1:567707333810:web:62ed841abe0e7bc011c5ab',
    messagingSenderId: '567707333810',
    projectId: 'creama-flutter',
    authDomain: 'creama-flutter.firebaseapp.com',
    storageBucket: 'creama-flutter.appspot.com',
  );

}