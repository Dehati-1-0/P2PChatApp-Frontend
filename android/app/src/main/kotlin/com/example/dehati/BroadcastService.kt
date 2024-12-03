package com.example.dehati
import android.content.Context
import android.app.Service
import android.content.Intent
import android.os.IBinder
import android.util.Log
import kotlinx.coroutines.*
import java.net.DatagramPacket
import java.net.DatagramSocket
import java.net.InetAddress

class BroadcastService : Service() {

    private var username = "Unknown"
    private val scope = CoroutineScope(Dispatchers.IO + SupervisorJob())

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
    val port = intent?.getIntExtra("port", 12345) ?: 12345
    val sharedPreferences = getSharedPreferences("com.example.dehati", Context.MODE_PRIVATE)
    username = sharedPreferences.getString("username", "Unknown") ?: "Unknown"
    startBroadcasting(port)
    return START_STICKY
}

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    private fun startBroadcasting(port: Int) {
        scope.launch {
            try {
                val broadcastAddress = InetAddress.getByName("255.255.255.255")
                val socket = DatagramSocket()
                socket.broadcast = true
                val localIpAddress = getLocalIpAddress() ?: return@launch
                val message = "DISCOVER:$localIpAddress:$username:${getDeviceModelName()}"
                val packet = DatagramPacket(message.toByteArray(), message.length, broadcastAddress, port)
                Log.d("BroadcastService", "Broadcasting: $message")
                while (true) {
                    socket.send(packet)
                    delay(5000L)
                }
            } catch (e: Exception) {
                e.printStackTrace()
                Log.e("BroadcastService", "Error broadcasting: ${e.message}")
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