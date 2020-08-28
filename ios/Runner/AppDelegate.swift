import UIKit
import Flutter
import Runner
import NativeContact

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let contactsChannel = FlutterMethodChannel(name: "com.example.fst_app_flutter/native",
                                              binaryMessenger: controller.binaryMessenger)
    contactsChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: FlutterResult) -> Void in
  // Note: this method is invoked on the UI thread.
  guard call.method == "saveNatively" else {
    result(FlutterMethodNotImplemented)
    return
  }
  var contact = NativeContact(call.arguments)
  contact.saveNatively()
  })
    GMSServices.provideAPIKey("AIzaSyC8crEFAO6MSNJMRK1lmo-WnSL7RLFu87w")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
