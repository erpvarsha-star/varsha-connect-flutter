import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('Firebase web options are not configured yet.');
    }

    return switch (defaultTargetPlatform) {
      TargetPlatform.android => android,
      _ => throw UnsupportedError(
          'Firebase options are only configured for Android right now.',
        ),
    };
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBmleMK_aNo-z9xDhtRKOUg2MKoMzPrg0',
    appId: '1:21534636847:android:2b0f9363cabf714f9fffda',
    messagingSenderId: '21534636847',
    projectId: 'yoyo-491123',
    storageBucket: 'yoyo-491123.firebasestorage.app',
  );
}
