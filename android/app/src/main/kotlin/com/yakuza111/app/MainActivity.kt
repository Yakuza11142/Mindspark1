package com.mindspark.app

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.BatteryManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val HARDWARE_CHANNEL = "com.mindspark.app/hardware"
    private val KV_CHANNEL = "com.mindspark.app/kv_store"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // Hardware integrations
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, HARDWARE_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getBatteryLevel" -> {
                    val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
                    result.success(batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY))
                }
                "launchUrl" -> {
                    val url = call.argument<String>("url")
                    val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url)).apply {
                        addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    }
                    startActivity(intent)
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }

        // Shared preferences native key-value storage replacement
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, KV_CHANNEL).setMethodCallHandler { call, result ->
            val prefs = getSharedPreferences("app_prefs", Context.MODE_PRIVATE)
            when (call.method) {
                "write" -> {
                    prefs.edit().putString(call.argument<String>("key"), call.argument<String>("value")).apply()
                    result.success(true)
                }
                "read" -> {
                    result.success(prefs.getString(call.argument<String>("key"), null))
                }
                else -> result.notImplemented()
            }
        }
    }
}
