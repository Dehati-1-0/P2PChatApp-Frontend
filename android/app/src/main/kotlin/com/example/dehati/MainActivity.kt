package com.example.dehati

import com.example.dehati.util.getLocalIpAddress
import com.example.dehati.util.getDeviceModelName
import android.content.Context
import android.content.Intent
import android.net.wifi.WifiManager
import android.os.Bundle
import android.util.Base64
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import java.io.BufferedReader
import java.io.InputStreamReader
import java.io.PrintWriter
import java.net.DatagramPacket
import java.net.DatagramSocket
import java.net.InetAddress
import java.net.ServerSocket
import java.security.KeyFactory
import java.security.KeyPair
import java.security.KeyPairGenerator
import java.security.PrivateKey
import java.security.spec.PKCS8EncodedKeySpec

class MainActivity: FlutterActivity() {

    private val DISCOVERED_DEVICES_CHANNEL = "com.example.p2pchat/discoveredDevices"
    private val BROADCAST_CHANNEL = "com.example.dehati/broadcast"
    private val SEND_MESSAGE_CHANNEL = "com.example.p2pchat/sendMessage"
    private val RECEIVE_MESSAGE_CHANNEL = "com.example.p2pchat/receiveMessage"
    private val KEYS_CHANNEL = "com.example.dehati/keys"
    private var eventSink: EventChannel.EventSink? = null
    private val scope = CoroutineScope(Dispatchers.IO + SupervisorJob())

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        startBroadcastService(12345) // Start the service with a default port
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val binaryMessenger = flutterEngine.dartExecutor.binaryMessenger

        EventChannel(binaryMessenger, DISCOVERED_DEVICES_CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events
                    val wifiManager = applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
                    listenForBroadcasts(wifiManager)
                }

                override fun onCancel(arguments: Any?) {
                    eventSink = null
                }
            }
        )

        MethodChannel(binaryMessenger, BROADCAST_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "startBroadcast") {
                val port = call.argument<Int>("port") ?: 8000
                startBroadcastService(port)
                result.success("Broadcast started on port $port")
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(binaryMessenger, SEND_MESSAGE_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "sendMessage") {
                val message = call.argument<String>("message")
                val serverIp = call.argument<String>("serverIp")
                val serverPort = call.argument<Int>("serverPort")
                if (message != null && serverIp != null && serverPort != null) {
                    sendMessage(message, serverIp, serverPort) { success ->
                        result.success(success)
                    }
                } else {
                    result.error("INVALID_ARGUMENTS", "Invalid arguments for sendMessage", null)
                }
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(binaryMessenger, RECEIVE_MESSAGE_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "startServer") {
                val port = call.argument<Int>("port") ?: 8000
                startServer(port) { message ->
                    runOnUiThread {
                        eventSink?.success(message)
                    }
                }
                result.success("Server started on port $port")
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(binaryMessenger, KEYS_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "generateKeyPair" -> {
                    val keyPair = generateKeyPair()
                    val publicKey = Base64.encodeToString(keyPair.public.encoded, Base64.DEFAULT)
                    val privateKey = Base64.encodeToString(keyPair.private.encoded, Base64.DEFAULT)
                    result.success(mapOf("publicKey" to publicKey, "privateKey" to privateKey))
                }
                "generatePublicKey" -> {
                    val privateKeyString = call.argument<String>("privateKey")
                    if (privateKeyString != null) {
                        try {
                            val publicKey = generatePublicKeyFromPrivate(privateKeyString)
                            result.success(publicKey)
                        } catch (e: Exception) {
                            result.error("KEY_GENERATION_FAILED", "Failed to generate public key", e.message)
                        }
                    } else {
                        result.error("INVALID_ARGUMENTS", "Invalid arguments for generatePublicKey", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun startBroadcastService(port: Int) {
        val intent = Intent(this, BroadcastService::class.java).apply {
            putExtra("port", port)
        }
        startService(intent)
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
                    if (message.startsWith("DISCOVER:") && !message.contains(localIpAddress as CharSequence, ignoreCase = true)) {
                        val parts = message.split(":")
                        if (parts.size >= 3) {
                            val ip = parts[1]
                            val modelName = parts[2]
                            val device = DiscoveredDevice(ip, modelName)
                            withContext(Dispatchers.Main) {
                                eventSink?.success(mapOf("ip" to device.ip, "modelName" to device.modelName))
                            }
                        }
                    }
                }
            } catch (e: Exception) {
                Log.e("P2PChatApp", "Error listening for broadcasts: ${e.message}")
            }
        }
    }

    private fun broadcastIp(port: Int) {
        scope.launch {
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
                    delay(5000L)
                }
            } catch (e: Exception) {
                e.printStackTrace()
                Log.e("P2PChatApp", "Error broadcasting IP: ${e.message}")
            }
        }
    }

    private fun generateKeyPair(): KeyPair {
        val keyGen = KeyPairGenerator.getInstance("RSA")
        keyGen.initialize(2048)
        return keyGen.genKeyPair()
    }

    private fun generatePublicKeyFromPrivate(privateKeyString: String): String {
        return try {
            val keySpec = PKCS8EncodedKeySpec(Base64.decode(privateKeyString, Base64.DEFAULT))
            val keyFactory = KeyFactory.getInstance("RSA")
            val privateKey: PrivateKey = keyFactory.generatePrivate(keySpec)

            val keyPairGenerator = KeyPairGenerator.getInstance("RSA")
            keyPairGenerator.initialize(2048)
            val keyPair = keyPairGenerator.generateKeyPair()

            val publicKey = keyPair.public
            Base64.encodeToString(publicKey.encoded, Base64.DEFAULT)
        } catch (e: Exception) {
            Log.e("KeyGeneration", "Failed to generate public key: ${e.message}")
            ""
        }
    }

    private fun sendMessage(message: String, serverIp: String, serverPort: Int, callback: (Boolean) -> Unit) {
        scope.launch {
            try {
                java.net.Socket(serverIp, serverPort).use { socket ->
                    val writer = PrintWriter(socket.getOutputStream(), true)
                    val reader = BufferedReader(InputStreamReader(socket.getInputStream()))

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

    fun startServer(port: Int, onMessageReceived: (String) -> Unit) {
        Thread {
            try {
                val serverSocket = ServerSocket(port)
                Log.d("P2PChatApp", "Server started on port $port")
                while (true) {
                    val clientSocket = serverSocket.accept()
                    val clientIp = clientSocket.inetAddress.hostAddress
                    Log.d("P2PChatApp", "Client connected: $clientIp")
                    val reader = BufferedReader(InputStreamReader(clientSocket.getInputStream()))
                    val message = reader.readLine()
                    if (message != null) {
                        Log.d("P2PChatApp", "Message received: $message")
                        runOnUiThread {
                            onMessageReceived(message)
                        }
                        val writer = PrintWriter(clientSocket.getOutputStream(), true)
                        writer.println("ACK")
                        writer.flush()
                    }
                    clientSocket.close()
                }
            } catch (e: Exception) {
                e.printStackTrace()
                Log.e("P2PChatApp", "Error starting server: ${e.message}")
            }
        }.start()
    }
}