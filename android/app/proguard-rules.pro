# ML Kit Proguard Rules
-keep class com.google.mlkit.vision.** { *; }
-keep class com.google.mlkit.nl.** { *; }
-dontwarn com.google.mlkit.**
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
