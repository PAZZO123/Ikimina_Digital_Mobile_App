package com.ikimina.digital

import io.flutter.embedding.android.FlutterFragmentActivity

// Using FlutterFragmentActivity instead of FlutterActivity
// because local_auth requires FragmentActivity for biometric dialogs
class MainActivity : FlutterFragmentActivity()
