# 🔐 Retains file and line numbers inside hidden debug symbols for error tracking
-keepattributes SourceFile,LineNumberTable
-keepattributes *Annotation*,Signature,InnerClasses

# 🦋 Protect Flutter Engine core structures from being broken by optimization
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# 🤖 Protect standard Android and Kotlin structural frameworks
-keep class androidx.annotation.** { *; }
-dontwarn class javax.annotation.**
-dontwarn class kotlin.**
