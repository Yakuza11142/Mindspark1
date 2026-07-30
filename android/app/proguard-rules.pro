-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }

-keepclassmembers class * {
  *** provider*;
}

-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

-keep class **.R
-keep class **.R$* { *; }

-keep class com.supabase.** { *; }
-keep interface com.supabase.** { *; }
-keepattributes Signature, *Annotation*, InnerClasses, EnclosingMethod

-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

-keepclassmembernames class * {
    *** b(...);
}

-keep class com.google.ar.core.** { *; }
-dontwarn com.google.ar.core.**

-keep class org.webrtc.** { *; }

-keep class com.google.android.gms.ads.** { *; }
-keep interface com.google.android.gms.ads.** { *; }

-keep class com.google.mlkit.** { *; }
-keep class com.google.android.gms.vision.** { *; }

-dontwarn com.google.android.gms.**
-dontwarn javax.annotation.**
-dontwarn okhttp3.**
-dontwarn okio.**
