# ==============================================================================
# Flutter & Core System Rules
# ==============================================================================
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }

# Keep provider
-keepclassmembers class * {
  *** provider*;
}

# Keep serialized objects
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Keep generated code
-keep class **.R
-keep class **.R$* { *; }

# ==============================================================================
# Supabase & Networking Rules
# ==============================================================================
-keep class com.supabase.** { *; }
-keep interface com.supabase.** { *; }
# Prevent optimization from breaking JSON parsing/reflection in Dio
-keepattributes Signature, *Annotation*, InnerClasses, EnclosingMethod

# Protects Dio network responses from breaking during JSON mapping
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# Protects Dart/JSON serialization layers for Supabase and WebRTC data structures
-keepclassmembernames class * {
    *** b(...);
}

# ==============================================================================
# Hardware, AR & AI Plugins (CRITICAL FOR YOUR LAB TECH STACK)
# ==============================================================================

# 1. ARCore Flutter Plus (Prevents native C++ crashes during tracking)
-keep class com.google.ar.core.** { *; }
-dontwarn com.google.ar.core.**

# 2. Flutter WebRTC (Protects the video streaming layers)
-keep class org.webrtc.** { *; }

# 3. Google Mobile Ads SDK (Prevents missing class errors on build)
-keep class com.google.android.gms.ads.** { *; }
-keep interface com.google.android.gms.ads.** { *; }

# 4. Google ML Kit Face Detection
-keep class com.google.mlkit.** { *; }
-keep class com.google.android.gms.vision.** { *; }

# 5. Build Warnings Suppressions
-dontwarn com.google.android.gms.**
-dontwarn javax.annotation.**
-dontwarn okhttp3.**
-dontwarn okio.**
