/*
 * Copyright (c) 2018-2021 HERE Global B.V. and its affiliate(s).
 * All rights reserved.
 *
 * This software and other materials contain proprietary information
 * controlled by HERE and are protected by applicable copyright legislation.
 * Any use and utilization of this software and other materials and
 * disclosure to any third parties is conditional upon having a separate
 * agreement with HERE for the access, use, utilization or disclosure of this
 * software. In the absence of such agreement, the use of the software is not
 * allowed.
 */

package com.here.here_sdk

import android.content.Context
import android.os.Build
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import com.here.sdk.mapview.MapController
import com.here.sdk.mapview.MapView
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class HereSdkPlugin() : HereSdkBasePlugin() {
    private var controllers : MutableList<MapController> = mutableListOf<MapController>()

    // Android embedding v1 implementation
    constructor(registrar: Registrar) : this() {
        this.registrar = registrar
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), METHOD_CHANNEL_NAME)
            val hereSdkPlugin = HereSdkPlugin(registrar)

            channel.setMethodCallHandler(hereSdkPlugin)
            registrar.platformViewRegistry().registerViewFactory(METHOD_CHANNEL_NAME, hereSdkPlugin)
        }
    }

    fun removeMapController(controller : MapController) {
        controllers.remove(controller)
        if (activityBinding != null) {
            controller.detachActivity(activityBinding!!.getActivity())
        }
    }

    override fun onAttachedToActivity(@NonNull binding: ActivityPluginBinding) {
        super.onAttachedToActivity(binding)

        for (c in controllers) {
            c.attachActivity(activityBinding!!.getActivity())
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {
        for (c in controllers) {
            c.detachActivity(activityBinding!!.getActivity())
        }

        super.onDetachedFromActivityForConfigChanges()
    }

    override fun onReattachedToActivityForConfigChanges(@NonNull binding: ActivityPluginBinding) {
        super.onReattachedToActivityForConfigChanges(binding)

        for (c in controllers) {
            c.attachActivity(activityBinding!!.getActivity())
        }
     }

    override fun onDetachedFromActivity() {
        for (c in controllers) {
            c.detachActivity(activityBinding!!.getActivity())
        }

        super.onDetachedFromActivity()
    }

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        var controller = MapController(viewId, this, MapView(context))
        controllers.add(controller);
        return controller
    }
}
