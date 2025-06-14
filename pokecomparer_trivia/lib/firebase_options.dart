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
    apiKey: 'AIzaSyC18v9eIzu8e5qXeCOQ9CfUiVOiCSjxjJY',
    appId: '1:806049097468:web:b2d5157e6aebb4fcecd979',
    messagingSenderId: '806049097468',
    projectId: 'pokecomparertrivia',
    authDomain: 'pokecomparertrivia.firebaseapp.com',
    storageBucket: 'pokecomparertrivia.firebasestorage.app',
    measurementId: 'G-VSY7XSZ1ZM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAkIr-9bzTMRGi1Mw5ix7sPTXkVXf6KGYo',
    appId: '1:806049097468:android:72a34f1c1991a3a3ecd979',
    messagingSenderId: '806049097468',
    projectId: 'pokecomparertrivia',
    storageBucket: 'pokecomparertrivia.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAbcK-Hlrysth5rOfRHVK1LLmQH1oC1E8M',
    appId: '1:806049097468:ios:3035cb96e6e85c81ecd979',
    messagingSenderId: '806049097468',
    projectId: 'pokecomparertrivia',
    storageBucket: 'pokecomparertrivia.firebasestorage.app',
    iosBundleId: 'com.example.pokecomparerTrivia',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAbcK-Hlrysth5rOfRHVK1LLmQH1oC1E8M',
    appId: '1:806049097468:ios:3035cb96e6e85c81ecd979',
    messagingSenderId: '806049097468',
    projectId: 'pokecomparertrivia',
    storageBucket: 'pokecomparertrivia.firebasestorage.app',
    iosBundleId: 'com.example.pokecomparerTrivia',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC18v9eIzu8e5qXeCOQ9CfUiVOiCSjxjJY',
    appId: '1:806049097468:web:943708e4b724f258ecd979',
    messagingSenderId: '806049097468',
    projectId: 'pokecomparertrivia',
    authDomain: 'pokecomparertrivia.firebaseapp.com',
    storageBucket: 'pokecomparertrivia.firebasestorage.app',
    measurementId: 'G-TZ14Q3HNPZ',
  );
}
