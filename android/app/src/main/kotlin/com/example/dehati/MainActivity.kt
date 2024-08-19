package com.example.dehati

import com.example.dehati.util.getLocalIpAddress
import com.example.dehati.util.getDeviceModelName
import android.content.Context
import android.net.wifi.WifiManager
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import java.net.DatagramPacket
import java.net.DatagramSocket
import java.net.InetAddress

data class DiscoveredDevice(val ip: String, val modelName: String)

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.p2pchat/discoveredDevices"
    private val METHOD_CHANNEL = "com.example.p2pchat/sendMessage"
    private var eventSink: EventChannel.EventSink? = null
    private val scope = CoroutineScope(Dispatchers.IO + SupervisorJob())

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Setup EventChannel for discovered devices
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events
                    val wifiManager = applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
                    listenForBroadcasts(wifiManager)
                }

                override fun onCancel(arguments: Any?) {
                    eventSink = null
                    scope.cancel()
                }
            }
        )

        // Setup MethodChannel for sending messages
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "sendMessage") {
                val message = call.argument<String>("message")
                val serverIp = call.argument<String>("serverIp")
                val serverPort = call.argument<Int>("serverPort")
                if (message != null && serverIp != null && serverPort != null) {
                    sendMessage(message, serverIp, serverPort) { success ->
                        result.success(success)
                    }
                } else {
                    result.error("INVALID_ARGUMENTS", "Message, IP, or Port missing", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun listenForBroadcasts(wifiManager: WifiManager) {
        scope.launch {
            try {
                val socket = DatagramSocket(12345, InetAddress.getByName("0.0.0.0"))
                socket.broadcast = true
                val buffer = ByteArray(1024)
                val localIpAddress = getLocalIpAddress() ?: return@launch
                val multicastLock = wifiManager.createMulticastLock("p2pchatapp").apply {
                    setReferenceCounted(true)
                    acquire()
                }

                while (true) {
                    val packet = DatagramPacket(buffer, buffer.size)
                    socket.receive(packet)
                    val message = String(packet.data, 0, packet.length)
                    if (message.startsWith("DISCOVER:") && !message.contains(localIpAddress)) {
                        val parts = message.split(":")
                        if (parts.size >= 3) {
                            val ip = parts[1]
                            val modelName = parts[2]
                            val device = DiscoveredDevice(ip, modelName)
                            Log.d("P2PChatApp", "Discovered device: $device")
                            withContext(Dispatchers.Main) {
                                eventSink?.success(mapOf("ip" to ip, "modelName" to modelName))
                            }
                        }
                    }
                }
            } catch (e: Exception) {
                Log.e("P2PChatApp", "Error listening for broadcasts: ${e.message}")
            }
        }
    }

    private fun sendMessage(message: String, serverIp: String, serverPort: Int, callback: (Boolean) -> Unit) {
        scope.launch {
            try {
                java.net.Socket(serverIp, serverPort).use { socket ->
                    val writer = java.io.PrintWriter(socket.getOutputStream(), true)
                    val reader = java.io.BufferedReader(java.io.InputStreamReader(socket.getInputStream()))

                    writer.println(message)
                    writer.flush()

                    socket.soTimeout = 5000
                    val response = reader.readLine()
                    callback(response == "ACK")
                }
            } catch (e: Exception) {
                Log.e("P2PChatApp", "Error sending message: ${e.message}")
                callback(false)
            }
        }
    }
}
