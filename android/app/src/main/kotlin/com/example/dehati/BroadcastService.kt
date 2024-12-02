package com.example.dehati

import android.app.Service
import android.content.Intent
import android.os.IBinder
import android.util.Log
import kotlinx.coroutines.*
import java.net.DatagramPacket
import java.net.DatagramSocket
import java.net.InetAddress
import android.content.Context

class BroadcastService : Service() {

    private val scope = CoroutineScope(Dispatchers.IO + SupervisorJob())

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val port = intent?.getIntExtra("port", 12345) ?: 12345
        startBroadcasting(port)
        return START_STICKY
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    private fun getUsername(): String {
        val sharedPreferences = getSharedPreferences("user_prefs", Context.MODE_PRIVATE)
        return sharedPreferences.getString("username", "Unknown") ?: "Unknown"
    }

    private fun startBroadcasting(port: Int) {
        scope.launch {
            try {
                val broadcastAddress = InetAddress.getByName("255.255.255.255")
                val socket = DatagramSocket()
                socket.broadcast = true
                val localIpAddress = getLocalIpAddress() ?: return@launch
                val message = "DISCOVER:$localIpAddress:${getDeviceModelName()}:${getUsername()}"
                val packet = DatagramPacket(message.toByteArray(), message.length, broadcastAddress, port)
                Log.d("BroadcastService", "Broadcasting IP: $localIpAddress")
                while (true) {
                    socket.send(packet)
                    delay(5000L)
                }
            } catch (e: Exception) {
                e.printStackTrace()
                Log.e("BroadcastService", "Error broadcasting IP: ${e.message}")
            }
        }
    }

    private fun getLocalIpAddress(): String? {
        return try {
            val interfaces = java.net.NetworkInterface.getNetworkInterfaces()
            while (interfaces.hasMoreElements()) {
                val networkInterface = interfaces.nextElement()
                val addresses = networkInterface.inetAddresses
                while (addresses.hasMoreElements()) {
                    val address = addresses.nextElement()
                    if (!address.isLoopbackAddress && address is java.net.Inet4Address) {
                        return address.hostAddress
                    }
                }
            }
            null
        } catch (e: Exception) {
            e.printStackTrace()
            Log.e("BroadcastService", "Error getting local IP address: ${e.message}")
            null
        }
    }

    private fun getDeviceModelName(): String {
        return android.os.Build.MODEL ?: "Unknown"
    }
}