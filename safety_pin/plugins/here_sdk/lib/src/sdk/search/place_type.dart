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

/// Specifies place type of Place result from a search query.
enum PlaceType {
    /// Describes either a building, floor level or a suite.
    @Deprecated("Will be removed in v4.10.0. [PlaceType.address] is used instead.")
    unit,
    /// House number.
    @Deprecated("Will be removed in v4.10.0. [PlaceType.address] is used instead.")
    houseNumber,
    /// House number with coordinates interpolated from the address range.
    @Deprecated("Will be removed in v4.10.0. [PlaceType.address] is used instead.")
    houseNumberInterpolated,
    /// Concerns addresses in Japan (Except Kyoto). It is a further subdivision under locality level,
    /// for example block and subblock to represent aza and chiban.
    @Deprecated("Will be removed in v4.10.0. [PlaceType.address] is used instead.")
    addressBlock,
    /// Typically a municipality or a district.
    @Deprecated("Will be removed in v4.10.0. [PlaceType.area] is used instead.")
    locality,
    /// Adminstrative area, for example a county, state/province.
    @Deprecated("Will be removed in v4.10.0. [PlaceType.area] is used instead.")
    administrativeArea,
    /// Point of interest, for example a shop, restaurant, museum.
    poi,
    /// Address of a place. It can have different formats based on the addressing system.
    address,
    /// Geographical area, for example a country, a city or a district.
    area,
    /// A street.
    street,
    /// An intersection of two, or more, streets.
    /// Note: This is a BETA feature and thus there can be bugs and unexpected behavior.
    /// Note: This type is not supported in offline search.
    intersection
}

// PlaceType "private" section, not exported.

int sdkSearchPlacetypeToFfi(PlaceType value) {
  switch (value) {
  case PlaceType.unit:
    return 0;
  case PlaceType.houseNumber:
    return 1;
  case PlaceType.houseNumberInterpolated:
    return 2;
  case PlaceType.addressBlock:
    return 3;
  case PlaceType.locality:
    return 4;
  case PlaceType.administrativeArea:
    return 5;
  case PlaceType.poi:
    return 6;
  case PlaceType.address:
    return 7;
  case PlaceType.area:
    return 8;
  case PlaceType.street:
    return 9;
  case PlaceType.intersection:
    return 10;
  default:
    throw StateError("Invalid enum value $value for PlaceType enum.");
  }
}

PlaceType sdkSearchPlacetypeFromFfi(int handle) {
  switch (handle) {
  case 0:
    return PlaceType.unit;
  case 1:
    return PlaceType.houseNumber;
  case 2:
    return PlaceType.houseNumberInterpolated;
  case 3:
    return PlaceType.addressBlock;
  case 4:
    return PlaceType.locality;
  case 5:
    return PlaceType.administrativeArea;
  case 6:
    return PlaceType.poi;
  case 7:
    return PlaceType.address;
  case 8:
    return PlaceType.area;
  case 9:
    return PlaceType.street;
  case 10:
    return PlaceType.intersection;
  default:
    throw StateError("Invalid numeric value $handle for PlaceType enum.");
  }
}

void sdkSearchPlacetypeReleaseFfiHandle(int handle) {}

final _sdkSearchPlacetypeCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Uint32),
    Pointer<Void> Function(int)
  >('here_sdk_sdk_search_PlaceType_create_handle_nullable'));
final _sdkSearchPlacetypeReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_search_PlaceType_release_handle_nullable'));
final _sdkSearchPlacetypeGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_search_PlaceType_get_value_nullable'));

Pointer<Void> sdkSearchPlacetypeToFfiNullable(PlaceType? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkSearchPlacetypeToFfi(value);
  final result = _sdkSearchPlacetypeCreateHandleNullable(_handle);
  sdkSearchPlacetypeReleaseFfiHandle(_handle);
  return result;
}

PlaceType? sdkSearchPlacetypeFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkSearchPlacetypeGetValueNullable(handle);
  final result = sdkSearchPlacetypeFromFfi(_handle);
  sdkSearchPlacetypeReleaseFfiHandle(_handle);
  return result;
}

void sdkSearchPlacetypeReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkSearchPlacetypeReleaseHandleNullable(handle);

// End of PlaceType "private" section.

