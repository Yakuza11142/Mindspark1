import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    
    let hardwareChannel = FlutterMethodChannel(name: "com.yakuza111.app/hardware", binaryMessenger: controller.binaryMessenger)
    let kvChannel = FlutterMethodChannel(name: "com.yakuza111.app/kv_store", binaryMessenger: controller.binaryMessenger)
    
    hardwareChannel.setMethodCallHandler({ (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "getBatteryLevel" {
        UIDevice.current.isBatteryMonitoringEnabled = true
        result(Int(UIDevice.current.batteryLevel * 100))
      } else if call.method == "launchUrl",
                let args = call.arguments as? [String: Any],
                let urlString = args["url"] as? String,
                let url = URL(string: urlString) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        result(true)
      } else {
        result(FlutterMethodNotImplemented)
      }
    })
    
    kvChannel.setMethodCallHandler({ (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "write",
         let args = call.arguments as? [String: Any],
         let key = args["key"] as? String,
         let value = args["value"] as? String {
        UserDefaults.standard.set(value, forKey: key)
        result(true)
      } else if call.method == "read",
                let args = call.arguments as? [String: Any],
                let key = args["key"] as? String {
        result(UserDefaults.standard.string(forKey: key))
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
