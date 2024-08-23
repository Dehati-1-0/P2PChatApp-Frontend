package com.example.dehati

import com.example.dehati.util.getLocalIpAddress
import com.example.dehati.util.getDeviceModelName
import android.content.Context
import android.net.wifi.WifiManager
import android.util.Base64
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import java.net.DatagramPacket
import java.net.DatagramSocket
import java.net.Inet4Address
import java.net.InetAddress
import java.security.KeyPair
import java.security.KeyPairGenerator
import java.security.KeyFactory
import java.security.PrivateKey
import java.security.spec.PKCS8EncodedKeySpec
import java.security.spec.X509EncodedKeySpec
data class DiscoveredDevice(val ip: String, val modelName: String)

class MainActivity: FlutterActivity() {

    private val DISCOVERED_DEVICES_CHANNEL = "com.example.p2pchat/discoveredDevices"
    private val BROADCAST_CHANNEL = "com.example.dehati/broadcast"
    private val SEND_MESSAGE_CHANNEL = "com.example.p2pchat/sendMessage"
    private val KEYS_CHANNEL = "com.example.dehati/keys"
    private var eventSink: EventChannel.EventSink? = null
    private val scope = CoroutineScope(Dispatchers.IO + SupervisorJob())

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, DISCOVERED_DEVICES_CHANNEL).setStreamHandler(
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

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BROADCAST_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "startBroadcast") {
                val port = call.argument<Int>("port") ?: 8000
                broadcastIp(port)
                result.success("Broadcast started on port $port")
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SEND_MESSAGE_CHANNEL).setMethodCallHandler { call, result ->
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

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, KEYS_CHANNEL).setMethodCallHandler { call, result ->
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
                            result.error("ERROR", "Failed to generate public key", e.message)
                        }
                    } else {
                        result.error("INVALID_ARGUMENT", "Private key is missing", null)
                    }
                }
                else -> result.notImplemented()
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

    private fun generateKeyPair(): KeyPair {
        val keyGen = KeyPairGenerator.getInstance("RSA")
        keyGen.initialize(2048)
        return keyGen.genKeyPair()
    }

    private fun generatePublicKeyFromPrivate(privateKeyString: String): String {
        return try {
            // Decode the private key string
            val keySpec = PKCS8EncodedKeySpec(Base64.decode(privateKeyString, Base64.DEFAULT))
            val keyFactory = KeyFactory.getInstance("RSA")
            val privateKey: PrivateKey = keyFactory.generatePrivate(keySpec)

            // Generate a key pair with the same algorithm and size as the private key
            val keyPairGenerator = KeyPairGenerator.getInstance("RSA")
            keyPairGenerator.initialize(2048) // This should match the private key size
            val keyPair = keyPairGenerator.generateKeyPair()

            // Extract the public key from the key pair
            val publicKey = keyPair.public

            // Convert the public key to a Base64 encoded string
            val publicKeyString = Base64.encodeToString(publicKey.encoded, Base64.DEFAULT)

            // Print the generated public key
            Log.d("KeyGeneration", "Generated Public Key: $publicKeyString")

            // Return the Base64 encoded public key
            publicKeyString
        } catch (e: Exception) {
            Log.e("KeyGeneration", "Failed to generate public key: ${e.message}")
            ""
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

    companion object {
        const val BROADCAST_INTERVAL = 5000L // 5 seconds
    }
}