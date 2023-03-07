package com.example.ai_ecard

import android.os.Environment
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    val FLUTTER_CHANNEL = "game.onechain.ai_ecard.module/utility"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            FLUTTER_CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "downloadDirectory" -> {
                    result.success(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS).toString())
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
