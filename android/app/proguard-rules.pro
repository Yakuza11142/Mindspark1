# ==============================================================================
# 🛑 TARGETED DEPENDENCY WARNING EXCLUSIONS (R8 CLEANUP)
# ==============================================================================
# Safely ignores missing optional platform classes from modern network clients
-dontwarn okhttp3.internal.platform.**
-dontwarn io.netty.**
-dontwarn org.conscrypt.**
-dontwarn sun.misc.Unsafe
-dontwarn org.bouncycastle.**
-dontwarn com.google.android.gms.internal.betterprinting.**

# Safely ignores compile-time checkers that are completely absent at runtime
-dontwarn com.google.errorprone.annotations.**
-dontwarn org.codehaus.mojo.animalsniffer.**
-dontwarn javax.annotation.**
-dontwarn org.checkerframework.**

# ==============================================================================
# 🔐 RETENTION RULES FOR ERROR TRACKING & REFLECTION
# ==============================================================================
# Preserves critical line numbers and class structures for meaningful stack traces
-keepattributes SourceFile,LineNumberTable
-keepattributes *Annotation*,Signature,InnerClasses,EnclosingMethod

# Protects data serialization keys from renaming (Ensures Supabase/API data loads)
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
    @kotlinx.serialization.SerialName <fields>;
}
-keep class kotlinx.serialization.** { *; }
-dontwarn kotlinx.serialization.**

# ==============================================================================
# 🦋 FLUTTER ENGINE CORE SYSTEM PROTECTION
# ==============================================================================
# Seamless channel communications between your Dart layer and native modules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# ==============================================================================
# 🤖 ANDROID SYSTEM JETPACK FRAMEWORK
# ==============================================================================
-keep class androidx.annotation.** { *; }
-keep class androidx.lifecycle.** { *; }

# ==============================================================================
# 🕶️ GOOGLE ARCORE PLATFORM INTEGRATION
# ==============================================================================
# Stops the obfuscation step from breaking JNI interfaces in AR features
-keep class com.google.ar.core.** { *; }
-dontwarn com.google.ar.core.**

# ==============================================================================
# 💵 GOOGLE MOBILE ADS SDK (ADMOB)
# ==============================================================================
# Keeps layout configurations intact so ad units display properly on devices
-keep class com.google.android.gms.ads.** { *; }
-keep class com.google.android.gms.internal.ads.** { *; }
-dontwarn com.google.android.gms.ads.**

# ==============================================================================
# 🌐 WEBVIEW COMPONENT LAYER
# ==============================================================================
-keep class io.flutter.plugins.webviewflutter.** { *; }

# ==============================================================================
# 🧠 GOOGLE GENERATIVE AI (GEMINI) DATA STRUCTURES
# ==============================================================================
-keep class com.google.ai.client.generativeai.** { *; }
-dontwarn com.google.ai.client.generativeai.**
