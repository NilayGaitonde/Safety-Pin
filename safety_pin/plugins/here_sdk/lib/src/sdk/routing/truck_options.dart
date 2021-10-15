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
import 'package:collection/collection.dart';
import 'package:here_sdk/src/_library_context.dart' as __lib;
import 'package:here_sdk/src/generic_types__conversion.dart';
import 'package:here_sdk/src/sdk/routing/avoidance_options.dart';
import 'package:here_sdk/src/sdk/routing/hazardous_good.dart';
import 'package:here_sdk/src/sdk/routing/route_options.dart';
import 'package:here_sdk/src/sdk/routing/route_text_options.dart';
import 'package:here_sdk/src/sdk/routing/truck_specifications.dart';
import 'package:here_sdk/src/sdk/routing/tunnel_category.dart';

/// All the options to specify how a truck route should be calculated.

class TruckOptions {
  /// Specifies the common route calculation options.
  RouteOptions routeOptions;

  /// Customize textual content returned from the route calculation, such
  /// as localization, format, and unit system.
  RouteTextOptions textOptions;

  /// Options to specify restrictions for route calculations. By default
  /// no restrictions are applied.
  AvoidanceOptions avoidanceOptions;

  /// Detailed truck specifications such as dimensions and weight.
  TruckSpecifications specifications;

  /// Specifies the tunnel categories to restrict certain route links.
  /// The route will pass only through tunnels of a less strict category.
  /// Refer to [TunnelCategory] for the available options.
  TunnelCategory? tunnelCategory;

  /// Specifies a list of hazardous materials shipped in the vehicle.
  /// Refer to [HazardousGood] for the available options.
  List<HazardousGood> hazardousGoods;

  TruckOptions(this.routeOptions, this.textOptions, this.avoidanceOptions, this.specifications, this.tunnelCategory, this.hazardousGoods);
  TruckOptions.withDefaults()
    : routeOptions = RouteOptions.withDefaults(), textOptions = RouteTextOptions.withDefaults(), avoidanceOptions = AvoidanceOptions.withDefaults(), specifications = TruckSpecifications.withDefaults(), tunnelCategory = null, hazardousGoods = [];
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TruckOptions) return false;
    TruckOptions _other = other;
    return routeOptions == _other.routeOptions &&
        textOptions == _other.textOptions &&
        avoidanceOptions == _other.avoidanceOptions &&
        specifications == _other.specifications &&
        tunnelCategory == _other.tunnelCategory &&
        DeepCollectionEquality().equals(hazardousGoods, _other.hazardousGoods);
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + routeOptions.hashCode;
    result = 31 * result + textOptions.hashCode;
    result = 31 * result + avoidanceOptions.hashCode;
    result = 31 * result + specifications.hashCode;
    result = 31 * result + tunnelCategory.hashCode;
    result = 31 * result + DeepCollectionEquality().hash(hazardousGoods);
    return result;
  }
}


// TruckOptions "private" section, not exported.

final _sdkRoutingTruckoptionsCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>)
  >('here_sdk_sdk_routing_TruckOptions_create_handle'));
final _sdkRoutingTruckoptionsReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TruckOptions_release_handle'));
final _sdkRoutingTruckoptionsGetFieldrouteOptions = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TruckOptions_get_field_routeOptions'));
final _sdkRoutingTruckoptionsGetFieldtextOptions = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TruckOptions_get_field_textOptions'));
final _sdkRoutingTruckoptionsGetFieldavoidanceOptions = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TruckOptions_get_field_avoidanceOptions'));
final _sdkRoutingTruckoptionsGetFieldspecifications = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TruckOptions_get_field_specifications'));
final _sdkRoutingTruckoptionsGetFieldtunnelCategory = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TruckOptions_get_field_tunnelCategory'));
final _sdkRoutingTruckoptionsGetFieldhazardousGoods = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TruckOptions_get_field_hazardousGoods'));



Pointer<Void> sdkRoutingTruckoptionsToFfi(TruckOptions value) {
  final _routeOptionsHandle = sdkRoutingRouteoptionsToFfi(value.routeOptions);
  final _textOptionsHandle = sdkRoutingRoutetextoptionsToFfi(value.textOptions);
  final _avoidanceOptionsHandle = sdkRoutingAvoidanceoptionsToFfi(value.avoidanceOptions);
  final _specificationsHandle = sdkRoutingTruckspecificationsToFfi(value.specifications);
  final _tunnelCategoryHandle = sdkRoutingTunnelcategoryToFfiNullable(value.tunnelCategory);
  final _hazardousGoodsHandle = heresdkRoutingCommonBindingslistofSdkRoutingHazardousgoodToFfi(value.hazardousGoods);
  final _result = _sdkRoutingTruckoptionsCreateHandle(_routeOptionsHandle, _textOptionsHandle, _avoidanceOptionsHandle, _specificationsHandle, _tunnelCategoryHandle, _hazardousGoodsHandle);
  sdkRoutingRouteoptionsReleaseFfiHandle(_routeOptionsHandle);
  sdkRoutingRoutetextoptionsReleaseFfiHandle(_textOptionsHandle);
  sdkRoutingAvoidanceoptionsReleaseFfiHandle(_avoidanceOptionsHandle);
  sdkRoutingTruckspecificationsReleaseFfiHandle(_specificationsHandle);
  sdkRoutingTunnelcategoryReleaseFfiHandleNullable(_tunnelCategoryHandle);
  heresdkRoutingCommonBindingslistofSdkRoutingHazardousgoodReleaseFfiHandle(_hazardousGoodsHandle);
  return _result;
}

TruckOptions sdkRoutingTruckoptionsFromFfi(Pointer<Void> handle) {
  final _routeOptionsHandle = _sdkRoutingTruckoptionsGetFieldrouteOptions(handle);
  final _textOptionsHandle = _sdkRoutingTruckoptionsGetFieldtextOptions(handle);
  final _avoidanceOptionsHandle = _sdkRoutingTruckoptionsGetFieldavoidanceOptions(handle);
  final _specificationsHandle = _sdkRoutingTruckoptionsGetFieldspecifications(handle);
  final _tunnelCategoryHandle = _sdkRoutingTruckoptionsGetFieldtunnelCategory(handle);
  final _hazardousGoodsHandle = _sdkRoutingTruckoptionsGetFieldhazardousGoods(handle);
  try {
    return TruckOptions(
      sdkRoutingRouteoptionsFromFfi(_routeOptionsHandle), 
      sdkRoutingRoutetextoptionsFromFfi(_textOptionsHandle), 
      sdkRoutingAvoidanceoptionsFromFfi(_avoidanceOptionsHandle), 
      sdkRoutingTruckspecificationsFromFfi(_specificationsHandle), 
      sdkRoutingTunnelcategoryFromFfiNullable(_tunnelCategoryHandle), 
      heresdkRoutingCommonBindingslistofSdkRoutingHazardousgoodFromFfi(_hazardousGoodsHandle)
    );
  } finally {
    sdkRoutingRouteoptionsReleaseFfiHandle(_routeOptionsHandle);
    sdkRoutingRoutetextoptionsReleaseFfiHandle(_textOptionsHandle);
    sdkRoutingAvoidanceoptionsReleaseFfiHandle(_avoidanceOptionsHandle);
    sdkRoutingTruckspecificationsReleaseFfiHandle(_specificationsHandle);
    sdkRoutingTunnelcategoryReleaseFfiHandleNullable(_tunnelCategoryHandle);
    heresdkRoutingCommonBindingslistofSdkRoutingHazardousgoodReleaseFfiHandle(_hazardousGoodsHandle);
  }
}

void sdkRoutingTruckoptionsReleaseFfiHandle(Pointer<Void> handle) => _sdkRoutingTruckoptionsReleaseHandle(handle);

// Nullable TruckOptions

final _sdkRoutingTruckoptionsCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TruckOptions_create_handle_nullable'));
final _sdkRoutingTruckoptionsReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TruckOptions_release_handle_nullable'));
final _sdkRoutingTruckoptionsGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TruckOptions_get_value_nullable'));

Pointer<Void> sdkRoutingTruckoptionsToFfiNullable(TruckOptions? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkRoutingTruckoptionsToFfi(value);
  final result = _sdkRoutingTruckoptionsCreateHandleNullable(_handle);
  sdkRoutingTruckoptionsReleaseFfiHandle(_handle);
  return result;
}

TruckOptions? sdkRoutingTruckoptionsFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkRoutingTruckoptionsGetValueNullable(handle);
  final result = sdkRoutingTruckoptionsFromFfi(_handle);
  sdkRoutingTruckoptionsReleaseFfiHandle(_handle);
  return result;
}

void sdkRoutingTruckoptionsReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkRoutingTruckoptionsReleaseHandleNullable(handle);

// End of TruckOptions "private" section.

