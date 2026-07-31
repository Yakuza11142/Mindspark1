# =========================================================================
# FLUTTER ENGINE & PLUGINS MATRIX
# =========================================================================
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }

-keepclassmembers class * {
  *** provider*;
}

# Preserve core serialization properties across native class bridges
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Retain system app resources cleanly to prevent build layout erasure
-keep class **.R
-keep class **.R$* { *; }

# =========================================================================
# AI & BACKEND CLOUD INFRASTRUCTURE (Supabase, OpenAI, Groq, Gemini)
# =========================================================================
-keep class com.supabase.** { *; }
-keep interface com.supabase.** { *; }

# FIXED: Comprehensive attribute preservation required for deep nested JSON decoding
-keepattributes Signature, *Annotation*, InnerClasses, EnclosingMethod, SourceFile, LineNumberTable

# Secure JSON serialization mappings from being stripped by R8 optimizations
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
    @com.google.crypto.tink.shaded.protobuf.SerializedName <fields>;
}

# =========================================================================
# HARDWARE OPTIMIZED AR ENGINE (ARCore & SceneView JNI Mappings)
# =========================================================================
-keep class com.google.ar.core.** { *; }
-keep class io.github.sceneview.** { *; }
-dontwarn com.google.ar.core.**
-dontwarn io.github.sceneview.**

# FIXED: Explicitly protects native method boundaries to prevent AR stream disconnections
-keepclasseswithmembernames class * {
    native <methods>;
}

# =========================================================================
# LOW-LATENCY WEBRTC STREAMING CORE (flutter_webrtc / Native C++)
# =========================================================================
-keep class org.webrtc.** { *; }
-keep interface org.webrtc.** { *; }
-dontwarn org.webrtc.**

# =========================================================================
# MOBILE HARDWARE & GOOGLE SERVICES LAYERS (Ads & ML Kit Engine)
# =========================================================================
-keep class com.google.android.gms.ads.** { *; }
-keep interface com.google.android.gms.ads.** { *; }

-keep class com.google.mlkit.** { *; }
-keep class com.google.android.gms.vision.** { *; }

# Safely mask compilation warnings coming from standard external packaging systems
-dontwarn com.google.android.gms.**
-dontwarn javax.annotation.**
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn sun.misc.**
