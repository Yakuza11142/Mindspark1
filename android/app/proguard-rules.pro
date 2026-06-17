# ==============================================================================
# 🛑 TARGETED DEPENDENCY WARNING EXCLUSIONS
# ==============================================================================
# Safely ignores missing optional classes from network clients (like Dio)
-dontwarn okhttp3.internal.platform.**
-dontwarn io.netty.**
-dontwarn org.conscrypt.**
-dontwarn sun.misc.Unsafe

# Safely ignores compile-time checker annotations that do not exist at runtime
-dontwarn com.google.errorprone.annotations.**
-dontwarn org.codehaus.mojo.animalsniffer.**
-dontwarn javax.annotation.**
-dontwarn kotlin.**

# ==============================================================================
# 🔐 RETENTION RULES FOR ERROR TRACKING
# ==============================================================================
# Preserves line numbers and source file names so error stack traces make sense
-keepattributes SourceFile,LineNumberTable
-keepattributes *Annotation*,Signature,InnerClasses,EnclosingMethod

# ==============================================================================
# 🦋 FLUTTER ENGINE CORE PROTECTION
# ==============================================================================
# Prevents the optimization engine from stripping away Flutter runtime links
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# ==============================================================================
# 🤖 ANDROID SYSTEM FRAMEWORK PROTECTION
# ==============================================================================
-keep class androidx.annotation.** { *; }
-keep class androidx.lifecycle.** { *; }

# ==============================================================================
# 🕶️ GOOGLE ARCORE DEVELOPMENT PROTECTION
# ==============================================================================
# Required to stop the --obfuscate command from breaking native AR Core features
-keep class com.google.ar.core.** { *; }
-dontwarn com.google.ar.core.**

# ==============================================================================
# 💵 GOOGLE MOBILE ADS SDK PROTECTION
# ==============================================================================
# Keeps AdMob code intact so ads load successfully on physical devices
-keep class com.google.android.gms.ads.** { *; }
-keep class com.google.android.gms.internal.ads.** { *; }
-dontwarn com.google.android.gms.ads.**

# ==============================================================================
# 🌐 WEBVIEW COMPONENT PROTECTION
# ==============================================================================
-keep class io.flutter.plugins.webviewflutter.** { *; }

# ==============================================================================
# 🧠 GOOGLE GENERATIVE AI (GEMINI) DATA PROTECTION
# ==============================================================================
# Keeps data serialization objects intact so Gemini AI models can talk to the app
-keep class com.google.ai.client.generativeai.** { *; }
-dontwarn com.google.ai.client.generativeai.**
