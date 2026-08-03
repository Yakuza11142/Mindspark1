// FIXED: Standardized target namespace parameters to match our build.gradle app specifications
package com.mindspark.app

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    // FIXED: Removed the obsolete SharedTalsec manual registration block. 
    // Modern FreeRASP packages handle native thread listeners automatically.
    // Keeping this file clean prevents platform channel collision flags during compilation passes.
}
