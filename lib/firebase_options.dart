// GENERATED FILE — Replace with your actual Firebase configuration
// Run: flutterfire configure
// See: https://firebase.google.com/docs/flutter/setup

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // ─────────────────────────────────────────────────────────────
  // IMPORTANT: Replace ALL values below with your Firebase project details.
  // Get them from: Firebase Console → Project Settings → Your Apps
  // ─────────────────────────────────────────────────────────────

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBaKYbbrbMWEKI8MYp63DN4jAEiqjZ4fio',
    appId: '1:1038490095433:android:9a4c9a2e1b5ae1db975498',
    messagingSenderId: '1038490095433',
    projectId: 'ikimina-digitalized',
    storageBucket: 'ikimina-digitalized.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyABQWX4euzDL5-Jsf0C-1je-secxWkap0Y',
    appId: '1:1038490095433:ios:48c8174971fb1a3b975498',
    messagingSenderId: '1038490095433',
    projectId: 'ikimina-digitalized',
    storageBucket: 'ikimina-digitalized.firebasestorage.app',
    iosBundleId: 'com.ikimina.app',
  );

}