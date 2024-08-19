package com.example.dehati

import android.content.Context
import android.net.wifi.WifiManager
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import com.example.dehati.network.BroadcastListener
import com.example.dehati.util.CoroutineScopeProvider
import kotlinx.coroutines.cancel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.p2pchat/discoveredDevices"
    private lateinit var eventSink: EventChannel.EventSink
    private val scope = CoroutineScopeProvider.provideScope()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events!!
                    val wifiManager = applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
                    BroadcastListener.listenForBroadcasts(wifiManager, eventSink, scope)
                }

                override fun onCancel(arguments: Any?) {
                    scope.cancel()
                }
            }
        )
    }
}
