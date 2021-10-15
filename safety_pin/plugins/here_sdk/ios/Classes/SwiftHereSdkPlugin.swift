//
// Copyright (c) 2018-2021 HERE Global B.V. and its affiliate(s).
// All rights reserved.
//
// This software and other materials contain proprietary information
// controlled by HERE and are protected by applicable copyright legislation.
// Any use and utilization of this software and other materials and
// disclosure to any third parties is conditional upon having a separate
// agreement with HERE for the access, use, utilization or disclosure of this
// software. In the absence of such agreement, the use of the software is not
// allowed.
//

import Flutter
import UIKit
import heresdk

public class SwiftHereSdkPlugin: SwiftHereSdkBasePlugin, FlutterPlugin, FlutterPlatformViewFactory {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftHereSdkPlugin(registrar)

        super.register(instance: instance, registrar: registrar)
        registrar.register(instance, withId: methodChannelName)

        registrar.addApplicationDelegate(instance)
    }

    public func applicationWillTerminate(_ application: UIApplication) {
        MapView.deinitialize()
    }

    public func applicationDidEnterBackground(_ application: UIApplication) {
        MapView.pause()
    }

    public func applicationWillEnterForeground(_ application: UIApplication) {
        MapView.resume()
    }

    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) ->
            FlutterPlatformView {
        let mapView = MapView(frame: frame)
        return MapController(viewIdentifier: viewId, registrar: registrar, mapView: mapView)
    }
}
