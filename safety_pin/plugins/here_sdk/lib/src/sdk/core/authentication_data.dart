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
import 'package:meta/meta.dart';

@immutable
class AuthenticationData {
  /// Secure token to be used with other HERE services. Note that the HERE SDK
  /// itself does not require the use of tokens.
  final String token;

  /// Expiration time in seconds as epoch time.
  final int expiryTimeInSeconds;

  const AuthenticationData(this.token, this.expiryTimeInSeconds);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AuthenticationData) return false;
    AuthenticationData _other = other;
    return token == _other.token &&
        expiryTimeInSeconds == _other.expiryTimeInSeconds;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + token.hashCode;
    result = 31 * result + expiryTimeInSeconds.hashCode;
    return result;
  }
}


// AuthenticationData "private" section, not exported.

final _sdkCoreAuthenticationdataCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>, Uint64),
    Pointer<Void> Function(Pointer<Void>, int)
  >('here_sdk_sdk_core_AuthenticationData_create_handle'));
final _sdkCoreAuthenticationdataReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_AuthenticationData_release_handle'));
final _sdkCoreAuthenticationdataGetFieldtoken = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_AuthenticationData_get_field_token'));
final _sdkCoreAuthenticationdataGetFieldexpiryTimeInSeconds = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint64 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_core_AuthenticationData_get_field_expiryTimeInSeconds'));



Pointer<Void> sdkCoreAuthenticationdataToFfi(AuthenticationData value) {
  final _tokenHandle = stringToFfi(value.token);
  final _expiryTimeInSecondsHandle = (value.expiryTimeInSeconds);
  final _result = _sdkCoreAuthenticationdataCreateHandle(_tokenHandle, _expiryTimeInSecondsHandle);
  stringReleaseFfiHandle(_tokenHandle);
  
  return _result;
}

AuthenticationData sdkCoreAuthenticationdataFromFfi(Pointer<Void> handle) {
  final _tokenHandle = _sdkCoreAuthenticationdataGetFieldtoken(handle);
  final _expiryTimeInSecondsHandle = _sdkCoreAuthenticationdataGetFieldexpiryTimeInSeconds(handle);
  try {
    return AuthenticationData(
      stringFromFfi(_tokenHandle), 
      (_expiryTimeInSecondsHandle)
    );
  } finally {
    stringReleaseFfiHandle(_tokenHandle);
    
  }
}

void sdkCoreAuthenticationdataReleaseFfiHandle(Pointer<Void> handle) => _sdkCoreAuthenticationdataReleaseHandle(handle);

// Nullable AuthenticationData

final _sdkCoreAuthenticationdataCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_AuthenticationData_create_handle_nullable'));
final _sdkCoreAuthenticationdataReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_AuthenticationData_release_handle_nullable'));
final _sdkCoreAuthenticationdataGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_AuthenticationData_get_value_nullable'));

Pointer<Void> sdkCoreAuthenticationdataToFfiNullable(AuthenticationData? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkCoreAuthenticationdataToFfi(value);
  final result = _sdkCoreAuthenticationdataCreateHandleNullable(_handle);
  sdkCoreAuthenticationdataReleaseFfiHandle(_handle);
  return result;
}

AuthenticationData? sdkCoreAuthenticationdataFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkCoreAuthenticationdataGetValueNullable(handle);
  final result = sdkCoreAuthenticationdataFromFfi(_handle);
  sdkCoreAuthenticationdataReleaseFfiHandle(_handle);
  return result;
}

void sdkCoreAuthenticationdataReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkCoreAuthenticationdataReleaseHandleNullable(handle);

// End of AuthenticationData "private" section.

