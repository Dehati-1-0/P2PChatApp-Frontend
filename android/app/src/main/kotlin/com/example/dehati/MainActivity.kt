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
    private val DISCOVERED_DEVICES_CHANNEL = "com.example.p2pchat/discoveredDevices"
    private val BROADCAST_CHANNEL = "com.example.dehati/broadcast"
    private lateinit var eventSink: EventChannel.EventSink
    private val scope = CoroutineScope(Dispatchers.IO + SupervisorJob())

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, DISCOVERED_DEVICES_CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events!!
                    val wifiManager = applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
                    listenForBroadcasts(wifiManager)
                }

                override fun onCancel(arguments: Any?) {
                    scope.cancel()
                }
            }
        )

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BROADCAST_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "startBroadcast") {
                val port = call.argument<Int>("port") ?: 8000
                broadcastIp(port)
                result.success("Broadcast started on port $port")
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
                wifiManager.createMulticastLock("p2pchatapp").apply {
                    setReferenceCounted(true)
                    acquire()
                }
                while (true) {
                    val packet = DatagramPacket(buffer, buffer.size)
                    socket.receive(packet)
                    val message = String(packet.data, 0, packet.length)
                    if (message.startsWith("DISCOVER:") && !message.contains(localIpAddress)) {
                        val parts = message.split(":")
                        val ip = parts[1]
                        val modelName = parts[2]
                        val device = DiscoveredDevice(ip, modelName)
                        Log.d("P2PChatApp", "Discovered device: $device")
                        withContext(Dispatchers.Main) {
                            eventSink.success(mapOf("ip" to ip, "modelName" to modelName))
                        }
                    }
                }
            } catch (e: Exception) {
                e.printStackTrace()
                Log.e("P2PChatApp", "Error listening for broadcasts: ${e.message}")
            }
        }
    }

    private fun broadcastIp(port: Int) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val broadcastAddress = InetAddress.getByName("255.255.255.255")
                val socket = DatagramSocket()
                socket.broadcast = true
                val localIpAddress = getLocalIpAddress() ?: return@launch
                val message = "DISCOVER:$localIpAddress:${getDeviceModelName()}"
                val packet = DatagramPacket(message.toByteArray(), message.length, broadcastAddress, port)
                Log.d("P2PChatApp", "Broadcasting IP: $localIpAddress")
                while (true) {
                    socket.send(packet)
                    Log.d("P2PChatApp", "Packet sent: $message")
                    Thread.sleep(BROADCAST_INTERVAL)
                }
            } catch (e: Exception) {
                e.printStackTrace()
                Log.e("P2PChatApp", "Error broadcasting IP: ${e.message}")
            }
        }
    }



    companion object {
        const val BROADCAST_INTERVAL = 5000L // 5 seconds
    }
}
