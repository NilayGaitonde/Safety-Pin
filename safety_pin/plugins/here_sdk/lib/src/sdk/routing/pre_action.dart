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
import 'package:here_sdk/src/sdk/routing/pre_action_type.dart';

/// An action that must be done prior to the section, i.e.
///
/// boarding a ferry.

class PreAction {
  /// Type of this action.
  PreActionType action;

  /// Estimated duration of this action in seconds.
  int durationInSeconds;

  PreAction(this.action, this.durationInSeconds);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PreAction) return false;
    PreAction _other = other;
    return action == _other.action &&
        durationInSeconds == _other.durationInSeconds;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + action.hashCode;
    result = 31 * result + durationInSeconds.hashCode;
    return result;
  }
}


// PreAction "private" section, not exported.

final _sdkRoutingPreactionCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Uint32, Int32),
    Pointer<Void> Function(int, int)
  >('here_sdk_sdk_routing_PreAction_create_handle'));
final _sdkRoutingPreactionReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_PreAction_release_handle'));
final _sdkRoutingPreactionGetFieldaction = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_routing_PreAction_get_field_action'));
final _sdkRoutingPreactionGetFielddurationInSeconds = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Int32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_routing_PreAction_get_field_durationInSeconds'));



Pointer<Void> sdkRoutingPreactionToFfi(PreAction value) {
  final _actionHandle = sdkRoutingPreactiontypeToFfi(value.action);
  final _durationInSecondsHandle = (value.durationInSeconds);
  final _result = _sdkRoutingPreactionCreateHandle(_actionHandle, _durationInSecondsHandle);
  sdkRoutingPreactiontypeReleaseFfiHandle(_actionHandle);
  
  return _result;
}

PreAction sdkRoutingPreactionFromFfi(Pointer<Void> handle) {
  final _actionHandle = _sdkRoutingPreactionGetFieldaction(handle);
  final _durationInSecondsHandle = _sdkRoutingPreactionGetFielddurationInSeconds(handle);
  try {
    return PreAction(
      sdkRoutingPreactiontypeFromFfi(_actionHandle), 
      (_durationInSecondsHandle)
    );
  } finally {
    sdkRoutingPreactiontypeReleaseFfiHandle(_actionHandle);
    
  }
}

void sdkRoutingPreactionReleaseFfiHandle(Pointer<Void> handle) => _sdkRoutingPreactionReleaseHandle(handle);

// Nullable PreAction

final _sdkRoutingPreactionCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_PreAction_create_handle_nullable'));
final _sdkRoutingPreactionReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_PreAction_release_handle_nullable'));
final _sdkRoutingPreactionGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_PreAction_get_value_nullable'));

Pointer<Void> sdkRoutingPreactionToFfiNullable(PreAction? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkRoutingPreactionToFfi(value);
  final result = _sdkRoutingPreactionCreateHandleNullable(_handle);
  sdkRoutingPreactionReleaseFfiHandle(_handle);
  return result;
}

PreAction? sdkRoutingPreactionFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkRoutingPreactionGetValueNullable(handle);
  final result = sdkRoutingPreactionFromFfi(_handle);
  sdkRoutingPreactionReleaseFfiHandle(_handle);
  return result;
}

void sdkRoutingPreactionReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkRoutingPreactionReleaseHandleNullable(handle);

// End of PreAction "private" section.

