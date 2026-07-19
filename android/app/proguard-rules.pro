# Flutter wrapper
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }

# Keep provider
-keepclassmembers class * {
  *** provider*;
}

# Keep supabase
-keep class com.supabase.** { *; }
-keep interface com.supabase.** { *; }

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
