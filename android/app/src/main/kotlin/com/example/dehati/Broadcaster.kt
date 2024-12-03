package com.example.dehati

import com.example.dehati.util.getLocalIpAddress
import kotlinx.coroutines.*
import java.net.DatagramPacket
import java.net.DatagramSocket
import java.net.InetAddress
import android.net.wifi.WifiManager
import android.util.Log

object Broadcaster {
    private val scope = CoroutineScope(Dispatchers.IO + SupervisorJob())

    fun startBroadcasting(port: Int, message: String) {
        scope.launch {
            try {
                val broadcastAddress = InetAddress.getByName("255.255.255.255")
                val socket = DatagramSocket()
                socket.broadcast = true
                val packet = DatagramPacket(message.toByteArray(), message.length, broadcastAddress, port)
                Log.d("Broadcaster", "Broadcasting message: $message")
                while (true) {
                    socket.send(packet)
                    delay(5000L)
                }
            } catch (e: Exception) {
                e.printStackTrace()
                Log.e("Broadcaster", "Error broadcasting message: ${e.message}")
            }
        }
    }

    fun listenForBroadcasts(wifiManager: WifiManager, onDeviceDiscovered: (DiscoveredDevice) -> Unit) {
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
                    if (message.startsWith("DISCOVER:") && !message.contains(localIpAddress as CharSequence, ignoreCase = true)) {
                        val parts = message.split(":")
                        if (parts.size >= 3) {
                            val ip = parts[1]
                            val modelName = parts[2]
                            val device = DiscoveredDevice(ip, modelName)
                            withContext(Dispatchers.Main) {
                                onDeviceDiscovered(device)
                            }
                        }
                    }
                }
            } catch (e: Exception) {
                Log.e("Broadcaster", "Error listening for broadcasts: ${e.message}")
            }
        }
    }
}