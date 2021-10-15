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
import 'package:here_sdk/src/sdk/routing/fare_price_type.dart';

/// Price of a fare.

class FarePrice {
  /// Type of price represented by this object.
  FarePriceType type;

  /// True when the fare price is estimated based on best guess and the actual price may differ. It is
  /// false when the price is not estimated.
  bool estimated;

  /// Local currency of the price compliant to ISO 4217. For example, "GBP" for the British pound sterling.
  String currency;

  /// When set, the price is paid for a specific duration.
  ///
  /// **Examples**:
  ///
  /// 3600 seconds - price for one hour
  ///
  /// 28800 seconds - price for eight hours
  ///
  /// 86400 seconds - price for one day
  @Deprecated("Will be removed in v4.10.0. Use [FarePrice.validityPeriodInSeconds] instead.")
  int? unit;

  /// When set, the price is paid for a specific duration.
  ///
  /// **Examples**:
  ///
  /// 3600 seconds - price for one hour
  ///
  /// 28800 seconds - price for eight hours
  ///
  /// 86400 seconds - price for one day
  ///
  /// **Note:** When the ticket validity period starts depends on the [Agency] providing the service.
  int? validityPeriodInSeconds;

  /// Minimum price when the price is of [FarePriceType.range] type. Otherwise, it is
  /// equal to [FarePrice.maximum].
  double minimum;

  /// Maximum price when the price is of [FarePriceType.range] type. Otherwise, it is
  /// equal to [FarePrice.minimum].
  double maximum;

  FarePrice(this.type, this.estimated, this.currency, this.unit, this.validityPeriodInSeconds, this.minimum, this.maximum);
  FarePrice.withDefaults(FarePriceType type, String currency, int? unit, int? validityPeriodInSeconds, double minimum, double maximum)
    : type = type, estimated = false, currency = currency, unit = unit, validityPeriodInSeconds = validityPeriodInSeconds, minimum = minimum, maximum = maximum;
}


// FarePrice "private" section, not exported.

final _sdkRoutingFarepriceCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Uint32, Uint8, Pointer<Void>, Pointer<Void>, Pointer<Void>, Double, Double),
    Pointer<Void> Function(int, int, Pointer<Void>, Pointer<Void>, Pointer<Void>, double, double)
  >('here_sdk_sdk_routing_FarePrice_create_handle'));
final _sdkRoutingFarepriceReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_FarePrice_release_handle'));
final _sdkRoutingFarepriceGetFieldtype = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_routing_FarePrice_get_field_type'));
final _sdkRoutingFarepriceGetFieldestimated = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint8 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_routing_FarePrice_get_field_estimated'));
final _sdkRoutingFarepriceGetFieldcurrency = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_FarePrice_get_field_currency'));
final _sdkRoutingFarepriceGetFieldunit = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_FarePrice_get_field_unit'));
final _sdkRoutingFarepriceGetFieldvalidityPeriodInSeconds = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_FarePrice_get_field_validityPeriodInSeconds'));
final _sdkRoutingFarepriceGetFieldminimum = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Double Function(Pointer<Void>),
    double Function(Pointer<Void>)
  >('here_sdk_sdk_routing_FarePrice_get_field_minimum'));
final _sdkRoutingFarepriceGetFieldmaximum = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Double Function(Pointer<Void>),
    double Function(Pointer<Void>)
  >('here_sdk_sdk_routing_FarePrice_get_field_maximum'));



Pointer<Void> sdkRoutingFarepriceToFfi(FarePrice value) {
  final _typeHandle = sdkRoutingFarepricetypeToFfi(value.type);
  final _estimatedHandle = booleanToFfi(value.estimated);
  final _currencyHandle = stringToFfi(value.currency);
  final _unitHandle = intToFfiNullable(value.unit);
  final _validityPeriodInSecondsHandle = intToFfiNullable(value.validityPeriodInSeconds);
  final _minimumHandle = (value.minimum);
  final _maximumHandle = (value.maximum);
  final _result = _sdkRoutingFarepriceCreateHandle(_typeHandle, _estimatedHandle, _currencyHandle, _unitHandle, _validityPeriodInSecondsHandle, _minimumHandle, _maximumHandle);
  sdkRoutingFarepricetypeReleaseFfiHandle(_typeHandle);
  booleanReleaseFfiHandle(_estimatedHandle);
  stringReleaseFfiHandle(_currencyHandle);
  intReleaseFfiHandleNullable(_unitHandle);
  intReleaseFfiHandleNullable(_validityPeriodInSecondsHandle);
  
  
  return _result;
}

FarePrice sdkRoutingFarepriceFromFfi(Pointer<Void> handle) {
  final _typeHandle = _sdkRoutingFarepriceGetFieldtype(handle);
  final _estimatedHandle = _sdkRoutingFarepriceGetFieldestimated(handle);
  final _currencyHandle = _sdkRoutingFarepriceGetFieldcurrency(handle);
  final _unitHandle = _sdkRoutingFarepriceGetFieldunit(handle);
  final _validityPeriodInSecondsHandle = _sdkRoutingFarepriceGetFieldvalidityPeriodInSeconds(handle);
  final _minimumHandle = _sdkRoutingFarepriceGetFieldminimum(handle);
  final _maximumHandle = _sdkRoutingFarepriceGetFieldmaximum(handle);
  try {
    return FarePrice(
      sdkRoutingFarepricetypeFromFfi(_typeHandle), 
      booleanFromFfi(_estimatedHandle), 
      stringFromFfi(_currencyHandle), 
      intFromFfiNullable(_unitHandle), 
      intFromFfiNullable(_validityPeriodInSecondsHandle), 
      (_minimumHandle), 
      (_maximumHandle)
    );
  } finally {
    sdkRoutingFarepricetypeReleaseFfiHandle(_typeHandle);
    booleanReleaseFfiHandle(_estimatedHandle);
    stringReleaseFfiHandle(_currencyHandle);
    intReleaseFfiHandleNullable(_unitHandle);
    intReleaseFfiHandleNullable(_validityPeriodInSecondsHandle);
    
    
  }
}

void sdkRoutingFarepriceReleaseFfiHandle(Pointer<Void> handle) => _sdkRoutingFarepriceReleaseHandle(handle);

// Nullable FarePrice

final _sdkRoutingFarepriceCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_FarePrice_create_handle_nullable'));
final _sdkRoutingFarepriceReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_FarePrice_release_handle_nullable'));
final _sdkRoutingFarepriceGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_FarePrice_get_value_nullable'));

Pointer<Void> sdkRoutingFarepriceToFfiNullable(FarePrice? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkRoutingFarepriceToFfi(value);
  final result = _sdkRoutingFarepriceCreateHandleNullable(_handle);
  sdkRoutingFarepriceReleaseFfiHandle(_handle);
  return result;
}

FarePrice? sdkRoutingFarepriceFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkRoutingFarepriceGetValueNullable(handle);
  final result = sdkRoutingFarepriceFromFfi(_handle);
  sdkRoutingFarepriceReleaseFfiHandle(_handle);
  return result;
}

void sdkRoutingFarepriceReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkRoutingFarepriceReleaseHandleNullable(handle);

// End of FarePrice "private" section.

