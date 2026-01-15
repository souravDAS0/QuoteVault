package com.example.quote_vault

import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.os.Build
import android.os.Handler
import android.os.Looper
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class ConnectivityPlugin private constructor(private val context: Context) :
    MethodChannel.MethodCallHandler,
    EventChannel.StreamHandler {

    companion object {
        private const val METHOD_CHANNEL = "com.quotevault/connectivity"
        private const val EVENT_CHANNEL = "com.quotevault/connectivity/stream"

        fun registerWith(flutterEngine: FlutterEngine, context: Context) {
            val plugin = ConnectivityPlugin(context)

            val methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL)
            methodChannel.setMethodCallHandler(plugin)

            val eventChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL)
            eventChannel.setStreamHandler(plugin)
        }
    }

    private val connectivityManager: ConnectivityManager by lazy {
        context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
    }

    private var eventSink: EventChannel.EventSink? = null
    private var networkCallback: ConnectivityManager.NetworkCallback? = null
    private val mainHandler = Handler(Looper.getMainLooper())

    // MethodChannel handler
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "checkConnectivity" -> {
                val status = getCurrentConnectivityStatus()
                result.success(status)
            }
            else -> result.notImplemented()
        }
    }

    // EventChannel StreamHandler
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
        registerNetworkCallback()
        // Send initial status
        sendConnectivityStatus()
    }

    override fun onCancel(arguments: Any?) {
        unregisterNetworkCallback()
        eventSink = null
    }

    private fun registerNetworkCallback() {
        if (networkCallback != null) return

        networkCallback = object : ConnectivityManager.NetworkCallback() {
            override fun onAvailable(network: Network) {
                mainHandler.post { sendConnectivityStatus() }
            }

            override fun onLost(network: Network) {
                mainHandler.post { sendConnectivityStatus() }
            }

            override fun onCapabilitiesChanged(
                network: Network,
                networkCapabilities: NetworkCapabilities
            ) {
                mainHandler.post { sendConnectivityStatus() }
            }
        }

        val networkRequest = NetworkRequest.Builder()
            .addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
            .build()

        try {
            connectivityManager.registerNetworkCallback(networkRequest, networkCallback!!)
        } catch (e: Exception) {
            // Handle registration failure gracefully
            e.printStackTrace()
        }
    }

    private fun unregisterNetworkCallback() {
        networkCallback?.let {
            try {
                connectivityManager.unregisterNetworkCallback(it)
            } catch (e: Exception) {
                // Callback might not be registered
                e.printStackTrace()
            }
        }
        networkCallback = null
    }

    private fun sendConnectivityStatus() {
        val status = getCurrentConnectivityStatus()
        eventSink?.success(status)
    }

    private fun getCurrentConnectivityStatus(): Map<String, Any> {
        val activeNetwork = connectivityManager.activeNetwork
        val capabilities = activeNetwork?.let { connectivityManager.getNetworkCapabilities(it) }

        val isConnected = capabilities?.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET) == true &&
                capabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_VALIDATED)

        val connectionType = when {
            capabilities == null -> "none"
            capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> "wifi"
            capabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> "cellular"
            capabilities.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) -> "ethernet"
            else -> "unknown"
        }

        return mapOf(
            "isConnected" to isConnected,
            "connectionType" to connectionType
        )
    }
}
