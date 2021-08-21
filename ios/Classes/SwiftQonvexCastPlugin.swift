import Flutter
import UIKit

public class SwiftQonvexCastPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "qonvex_cast", binaryMessenger: registrar.messenger())
    let instance = SwiftQonvexCastPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    let factory = AirPlayFactory(registrar: registrar)
    let chromeCastFactory = ChromeCastFactory(registrar: registrar)
    registrar.register(factory, withId: "AirPlayButton")
    registrar.register(chromeCastFactory, withId: "ChromeCastButton")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
