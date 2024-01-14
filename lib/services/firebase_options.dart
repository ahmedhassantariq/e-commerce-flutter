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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAizJIbfFeOCd18iy9UFiOS21WzN6wQjII',
    appId: '1:342650286989:web:8f14d5d0c4b14aae0083c4',
    messagingSenderId: '342650286989',
    projectId: 'delivery-87e23',
    authDomain: 'delivery-87e23.firebaseapp.com',
    storageBucket: 'delivery-87e23.appspot.com',
    measurementId: 'G-LY81RYQ8B4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC7MwiTD_dQSJ7ashM_4Xm-wJEpqFEvrQo',
    appId: '1:342650286989:android:e9fc3ac8886442950083c4',
    messagingSenderId: '342650286989',
    projectId: 'delivery-87e23',
    storageBucket: 'delivery-87e23.appspot.com',
  );
}