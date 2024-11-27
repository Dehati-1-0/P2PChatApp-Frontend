package com.example.dehati

import android.app.Application
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch
import kotlinx.coroutines.delay
import java.net.DatagramPacket
import java.net.DatagramSocket
import java.net.InetAddress
import android.util.Log
import com.example.dehati.util.getLocalIpAddress
import com.example.dehati.util.getDeviceModelName

class MyApplication : Application() {
    val applicationScope = CoroutineScope(Dispatchers.IO + SupervisorJob())

    override fun onCreate() {
        super.onCreate()
        startBroadcasting()
    }

    private fun startBroadcasting() {
        applicationScope.launch {
            try {
                val broadcastAddress = InetAddress.getByName("255.255.255.255")
                val socket = DatagramSocket()
                socket.broadcast = true
                val localIpAddress = getLocalIpAddress() ?: return@launch
                val message = "DISCOVER:$localIpAddress:${getDeviceModelName()}"
                val packet = DatagramPacket(message.toByteArray(), message.length, broadcastAddress, 8000)
                Log.d("P2PChatApp", "Broadcasting IP: $localIpAddress")
                while (true) {
                    socket.send(packet)
                    delay(5000L)
                }
            } catch (e: Exception) {
                e.printStackTrace()
                Log.e("P2PChatApp", "Error broadcasting IP: ${e.message}")
            }
        }
    }
}