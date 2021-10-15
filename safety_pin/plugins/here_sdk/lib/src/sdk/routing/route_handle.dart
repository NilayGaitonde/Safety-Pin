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

import 'dart:ffi';
import 'package:here_sdk/src/_library_context.dart' as __lib;
import 'package:here_sdk/src/builtin_types__conversion.dart';

/// Provides an internal representation of a [Route] including all parameters such
/// as waypoints, shape and options.
///
/// Note that the [Route.routeHandle] is provided only
/// if [RouteOptions.enableRouteHandle] is set before route calculation. When a route handle
/// object is submitted, its encoded data is accessed in an opaque way.
///
/// **Note:** This is a beta release of this feature, so there could be a few bugs and unexpected behaviors.
/// Related APIs may change for new releases without a deprecation process.

class RouteHandle {
  /// @nodoc
  String internalencodedData;

  RouteHandle(this.internalencodedData);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RouteHandle) return false;
    RouteHandle _other = other;
    return internalencodedData == _other.internalencodedData;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + internalencodedData.hashCode;
    return result;
  }
}


// RouteHandle "private" section, not exported.

final _sdkRoutingRoutehandleCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RouteHandle_create_handle'));
final _sdkRoutingRoutehandleReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RouteHandle_release_handle'));
final _sdkRoutingRoutehandleGetFieldencodedData = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RouteHandle_get_field_encodedData'));



Pointer<Void> sdkRoutingRoutehandleToFfi(RouteHandle value) {
  final _encodedDataHandle = stringToFfi(value.internalencodedData);
  final _result = _sdkRoutingRoutehandleCreateHandle(_encodedDataHandle);
  stringReleaseFfiHandle(_encodedDataHandle);
  return _result;
}

RouteHandle sdkRoutingRoutehandleFromFfi(Pointer<Void> handle) {
  final _encodedDataHandle = _sdkRoutingRoutehandleGetFieldencodedData(handle);
  try {
    return RouteHandle(
      stringFromFfi(_encodedDataHandle)
    );
  } finally {
    stringReleaseFfiHandle(_encodedDataHandle);
  }
}

void sdkRoutingRoutehandleReleaseFfiHandle(Pointer<Void> handle) => _sdkRoutingRoutehandleReleaseHandle(handle);

// Nullable RouteHandle

final _sdkRoutingRoutehandleCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RouteHandle_create_handle_nullable'));
final _sdkRoutingRoutehandleReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RouteHandle_release_handle_nullable'));
final _sdkRoutingRoutehandleGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RouteHandle_get_value_nullable'));

Pointer<Void> sdkRoutingRoutehandleToFfiNullable(RouteHandle? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkRoutingRoutehandleToFfi(value);
  final result = _sdkRoutingRoutehandleCreateHandleNullable(_handle);
  sdkRoutingRoutehandleReleaseFfiHandle(_handle);
  return result;
}

RouteHandle? sdkRoutingRoutehandleFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkRoutingRoutehandleGetValueNullable(handle);
  final result = sdkRoutingRoutehandleFromFfi(_handle);
  sdkRoutingRoutehandleReleaseFfiHandle(_handle);
  return result;
}

void sdkRoutingRoutehandleReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkRoutingRoutehandleReleaseHandleNullable(handle);

// End of RouteHandle "private" section.

