# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.kts.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Google Play Core library (optional dependency for Flutter deferred components)
# These classes are referenced by Flutter but not used if app doesn't use dynamic feature modules
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task

# Keep all annotations
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes InnerClasses
-keepattributes EnclosingMethod

# Flutter Local Notifications Plugin
# Keep all notification-related classes from the plugin
-keep class com.dexterous.flutterlocalnotifications.** { *; }
-keep interface com.dexterous.flutterlocalnotifications.** { *; }

# Keep AndroidX notification classes
-keep class androidx.core.app.NotificationCompat** { *; }
-keep class androidx.core.app.NotificationManagerCompat { *; }

# WorkManager
# Keep all Worker classes and their methods
-keep class * extends androidx.work.Worker {
    public <init>(...);
    public void onStopped();
}
-keep class * extends androidx.work.ListenableWorker {
    public <init>(...);
    public androidx.work.ListenableWorker$Result startWork();
}

# Keep WorkManager core classes
-keep class androidx.work.** { *; }
-keep interface androidx.work.** { *; }

# Keep WorkManager configuration
-keep class androidx.work.Configuration { *; }
-keep class androidx.work.WorkManager { *; }
-keep class androidx.work.impl.** { *; }

# Flutter Plugin System
# Keep Flutter plugin classes and callback mechanisms
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.plugin.common.** { *; }
-keep class io.flutter.embedding.engine.** { *; }
-keep class io.flutter.embedding.engine.plugins.** { *; }

# Flutter Callback Dispatcher
# Critical for WorkManager background execution
-keep class io.flutter.embedding.engine.FlutterJNI { *; }
-keep class io.flutter.embedding.engine.dart.DartExecutor { *; }
-keep class io.flutter.view.FlutterCallbackInformation { *; }

# Keep classes annotated with @Keep
-keep @androidx.annotation.Keep class * { *; }
-keep @androidx.annotation.Keep interface * { *; }

-keepclassmembers class * {
    @androidx.annotation.Keep *;
}

# Gson (used by WorkManager and flutter_local_notifications for serialization)
# Keep generic signature of gson classes - CRITICAL for TypeToken to work
-keepattributes Signature

# Keep Gson annotations
-keepattributes *Annotation*

# Keep all Gson classes to prevent "Missing type parameter" errors
-keep class com.google.gson.** { *; }
-keep class com.google.gson.reflect.** { *; }
-keep class com.google.gson.stream.** { *; }

# Keep TypeToken and its generic type information
-keep class com.google.gson.reflect.TypeToken { *; }
-keep class * extends com.google.gson.reflect.TypeToken

# Prevent stripping of generic signatures in classes that use Gson
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-keepattributes InnerClasses

# Keep data classes used in WorkManager
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# Keep all fields and methods in flutter_local_notifications classes
# This prevents Gson from failing when trying to serialize/deserialize notification data
-keepclassmembers class com.dexterous.flutterlocalnotifications.** {
    <fields>;
    <methods>;
}

# Keep all inner classes in the plugin (like FlutterLocalNotificationsPlugin$1)
-keepclassmembers class com.dexterous.flutterlocalnotifications.*$* {
    *;
}

# Prevent obfuscation of enum classes
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Preserve line number information for debugging stack traces
-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to hide the original source file name
# -renamesourcefileattribute SourceFile
