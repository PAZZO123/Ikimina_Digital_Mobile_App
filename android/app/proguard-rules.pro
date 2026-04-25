# Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Dart/Flutter
-dontwarn io.flutter.embedding.**

# Keep model classes (Gson / JSON serialization)
-keepattributes Signature
-keepattributes *Annotation*
-keepclassmembers class ** {
    @com.google.gson.annotations.SerializedName <fields>;
}

# SQLite / Drift
-keep class com.tekartik.sqflite.** { *; }
-dontwarn org.sqlite.**

# Biometric
-keep class androidx.biometric.** { *; }

# PDF
-keep class com.tom_roush.pdfbox.** { *; }
