package com.example.dehati.network

import android.net.wifi.WifiManager
import android.util.Log
import com.example.dehati.data.model.DiscoveredDevice
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.net.DatagramPacket
import java.net.DatagramSocket
import java.net.InetAddress

object BroadcastListener {

    fun listenForBroadcasts(wifiManager: WifiManager, eventSink: EventChannel.EventSink, scope: CoroutineScope) {
        scope.launch {
            try {
                val socket = DatagramSocket(12345, InetAddress.getByName("0.0.0.0"))
                socket.broadcast = true
                val buffer = ByteArray(1024)
                val localIpAddress = NetworkUtils.getLocalIpAddress() ?: return@launch
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
}
