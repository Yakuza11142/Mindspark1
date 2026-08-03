# =========================================================================
# SYSTEM AGGREGATION & FLUTTER CORE RUNTIME MATRIX
# =========================================================================
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class com.google.android.gms.** { *; }
-keep interface com.google.android.gms.** { *; }
-keep class com.google.firebase.components.** { *; }
-keep class **.R
-keep class **.R$* { *; }

-keep class androidx.lifecycle.** { *; }
-keep class androidx.window.** { *; }
-keep class androidx.sqlite.** { *; }

-keepclassmembers class * { *** provider*; }
-keepattributes Signature, *Annotation*, InnerClasses, EnclosingMethod, SourceFile, LineNumberTable

# Preserve Core JVM Data Serialization Bridges
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# =========================================================================
# APPLICATION SECURITY & ANTI-TAMPER SHIELDS (FreeRASP Native Integration)
# =========================================================================
-keep class com.aheadintech.freerasp.** { *; }
-keep interface com.aheadintech.freerasp.** { *; }
-dontwarn com.aheadintech.freerasp.**
-keepclasseswithmembers class com.aheadintech.freerasp.** { *; }

# =========================================================================
# DRIFT RELATIONAL STORAGE SYSTEM & SQLITE JNI BINDINGS
# =========================================================================
-keep class org.sqlite.** { *; }
-keep interface org.sqlite.** { *; }
-dontwarn org.sqlite.**
-dontwarn androidx.sqlite.**
-dontwarn database.**
-keep class deniswong.** { *; } 
-keep class com.tekartik.sqflite.** { *; }
-dontwarn com.tekartik.sqflite.**

# =========================================================================
# BACKEND CLOUD INFRASTRUCTURE & HTTP NETWORKING ENGINES (Supabase & Dio)
# =========================================================================
-keep class com.supabase.** { *; }
-keep interface com.supabase.** { *; }

-keepclassmembers class * {
    @com.google.crypto.tink.shaded.protobuf.SerializedName <fields>;
    *** fromJson(...);
    *** toJson(...);
    *** fromMap(...);
    *** toMap(...);
}

# =========================================================================
# ARTIFICIAL INTELLIGENCE & NATURAL LANGUAGE EXTENSIONS
# =========================================================================
-keep class com.google.ai.client.generativeai.** { *; }
-dontwarn com.google.ai.client.generativeai.**

# =========================================================================
# HARDWARE OPTIMIZED AR ENGINE (ARCore & SceneView JNI Mappings)
# =========================================================================
-keep class com.google.ar.core.** { *; }
-keep class io.github.sceneview.** { *; }
-dontwarn com.google.ar.core.**
-dontwarn io.github.sceneview.**
-keepclasseswithmembernames class * { native <methods>; }

# =========================================================================
# LIVE CAPTURE HARDWARE & REALTIME AUDIO-VIDEO WEBRTC STREAMING
# =========================================================================
-keep class org.webrtc.** { *; }
-keep interface org.webrtc.** { *; }
-dontwarn org.webrtc.**
-dontwarn org.bouncycastle.**
-dontwarn org.conscrypt.**
-keep class io.flutter.plugins.camera.** { *; }
-keep class io.flutter.plugins.imagepicker.** { *; }
-keep class com.vraph.flutter_image_compress.** { *; }
-dontwarn com.vraph.flutter_image_compress.**

# =========================================================================
# PLATFORM SYSTEM MULTIMEDIA: TEXT-TO-SPEECH & AUDIO SERVICES
# =========================================================================
-keep class com.tundralabs.fluttertts.** { *; }
-dontwarn com.tundralabs.fluttertts.**
-keep class xyz.luan.audioplayers.** { *; }
-dontwarn xyz.luan.audioplayers.**
-keep class com.ryanheise.audio_session.** { *; }
-dontwarn com.ryanheise.audio_session.**

# =========================================================================
# MONETIZATION, WALLET INTEGRATION & KEY-VALUE SYSTEMS
# =========================================================================
-keep class com.android.billingclient.** { *; }
-dontwarn com.android.billingclient.**
-keep class io.flutter.plugins.sharedpreferences.** { *; }
-keep class com.it_rent.flutter_secure_storage.** { *; }
-dontwarn com.it_rent.flutter_secure_storage.**

# =========================================================================
# MOBILE HARDWARE SENSORS, PERMISSIONS & CONTEXT BINDINGS (Plus Plugins)
# =========================================================================
-keep class dev.fluttercommunity.plus.** { *; }
-keep class com.baseflow.permissionhandler.** { *; }
-keep class io.flutter.plugins.urllauncher.** { *; }
-keep class com.github.alunny.vibration.** { *; }
-keep class io.github.g00fy2.versioncompare.** { *; }
-keep class com.pichillilorenzo.flutter_app_links.** { *; }
-dontwarn com.pichillilorenzo.flutter_app_links.**

# =========================================================================
# EMBEDDED COGNITIVE INTEL: ON-DEVICE COMPUTER VISION (Google ML Kit Engine)
# =========================================================================
-keep class com.google.mlkit.** { *; }
-keep class com.google.android.gms.vision.** { *; }
-dontwarn com.google.android.datatransport.**

# =========================================================================
# GOOGLE MOBILE ADS UTILITIES
# =========================================================================
-keep class com.google.android.gms.ads.** { *; }
-keep interface com.google.android.gms.ads.** { *; }

# =========================================================================
# DEEP WEBVIEW EMBEDS & DOCUMENT COMPRESSION INTERFACES
# =========================================================================
-keep class io.flutter.plugins.webviewflutter.** { *; }
-dontwarn io.flutter.plugins.webviewflutter.**
-keep class com.shockwave.** { *; }
-dontwarn com.shockwave.**

# =========================================================================
# BIOMETRICS & NATIVE PLATFORM SECURITY INTERFACES
# =========================================================================
-keep class io.flutter.plugins.localauth.** { *; }
-dontwarn io.flutter.plugins.localauth.**
# FIXED: Resolved tokens context pass by wiping the duplicated 'class' phrase key
-keep class io.flutter.plugins.flutter_windowmanager.** { *; }
-keep class github.nisrulz.screenbrightness.** { *; }
-dontwarn github.nisrulz.screenbrightness.**

# =========================================================================
# APP CUSTOM UI ARCHITECTURE: SHIMMER, TICKETS, ANIMATIONS & WHEELS
# =========================================================================
-keep class io.github.shreyaspatil.ticketview.** { *; }
-dontwarn io.github.shreyaspatil.ticketview.**
-keep class ca.barrenechea.shimmer.** { *; }
-dontwarn ca.barrenechea.shimmer.**
-dontwarn com.flutter_fortune_wheel.**
-keep class nl.dionsegijn.confetti.** { *; }
-dontwarn nl.dionsegijn.confetti.**

# =========================================================================
# HARDWARE SENSORS & SYSTEM DIAGNOSTICS (Environment, Carrier, Battery)
# =========================================================================
-keep class io.github.jclehner.clw.** { *; }
-dontwarn io.github.jclehner.clw.**
-keep class com.lyokone.carrier_info.** { *; }
-dontwarn com.lyokone.carrier_info.**
-keep class io.github.mitchmcclements.environment_sensors.** { *; }
-dontwarn io.github.mitchmcclements.environment_sensors.**

# =========================================================================
# EXTERNAL WRAPPER DICTIONARIES & EXPLICIT WARNING CANCELLATIONS
# =========================================================================
-dontwarn com.google.android.gms.**
-dontwarn com.google.android.datatransport.**
-dontwarn com.google.firebase.components.**
-dontwarn androidx.**
-dontwarn javax.annotation.**
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn sun.misc.**
