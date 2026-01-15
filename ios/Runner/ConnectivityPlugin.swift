import Flutter
import Network

class ConnectivityPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {

    private static let methodChannelName = "com.quotevault/connectivity"
    private static let eventChannelName = "com.quotevault/connectivity/stream"

    private var eventSink: FlutterEventSink?
    private var pathMonitor: NWPathMonitor?
    private let monitorQueue = DispatchQueue(label: "com.quotevault.connectivity.monitor")

    static func register(with registrar: FlutterPluginRegistrar) {
        let instance = ConnectivityPlugin()

        let methodChannel = FlutterMethodChannel(
            name: methodChannelName,
            binaryMessenger: registrar.messenger()
        )
        registrar.addMethodCallDelegate(instance, channel: methodChannel)

        let eventChannel = FlutterEventChannel(
            name: eventChannelName,
            binaryMessenger: registrar.messenger()
        )
        eventChannel.setStreamHandler(instance)
    }

    // MARK: - FlutterPlugin

    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "checkConnectivity":
            checkConnectivity(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func checkConnectivity(result: @escaping FlutterResult) {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            let status = self?.getConnectivityStatus(from: path) ?? [
                "isConnected": false,
                "connectionType": "none"
            ]
            DispatchQueue.main.async {
                result(status)
            }
            monitor.cancel()
        }
        monitor.start(queue: monitorQueue)
    }

    // MARK: - FlutterStreamHandler

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        startMonitoring()
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        stopMonitoring()
        eventSink = nil
        return nil
    }

    // MARK: - Network Monitoring

    private func startMonitoring() {
        guard pathMonitor == nil else { return }

        pathMonitor = NWPathMonitor()
        pathMonitor?.pathUpdateHandler = { [weak self] path in
            self?.handlePathUpdate(path)
        }
        pathMonitor?.start(queue: monitorQueue)
    }

    private func stopMonitoring() {
        pathMonitor?.cancel()
        pathMonitor = nil
    }

    private func handlePathUpdate(_ path: NWPath) {
        let status = getConnectivityStatus(from: path)
        DispatchQueue.main.async { [weak self] in
            self?.eventSink?(status)
        }
    }

    private func getConnectivityStatus(from path: NWPath) -> [String: Any] {
        let isConnected = path.status == .satisfied

        let connectionType: String
        if path.usesInterfaceType(.wifi) {
            connectionType = "wifi"
        } else if path.usesInterfaceType(.cellular) {
            connectionType = "cellular"
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = "ethernet"
        } else if isConnected {
            connectionType = "unknown"
        } else {
            connectionType = "none"
        }

        return [
            "isConnected": isConnected,
            "connectionType": connectionType
        ]
    }
}
