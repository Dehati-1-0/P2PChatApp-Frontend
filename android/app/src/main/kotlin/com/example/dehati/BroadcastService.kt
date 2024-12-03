package com.example.dehati

import android.app.Service
import android.content.Intent
import android.os.IBinder
import com.example.dehati.util.getLocalIpAddress
import com.example.dehati.util.getDeviceModelName
import kotlinx.coroutines.*

class BroadcastService : Service() {

    private val scope = CoroutineScope(Dispatchers.IO + SupervisorJob())

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val port = intent?.getIntExtra("port", 12345) ?: 12345
        val message = "DISCOVER:${getLocalIpAddress()}:${getDeviceModelName()}"
        Broadcaster.startBroadcasting(port, message)
        return START_STICKY
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }
}