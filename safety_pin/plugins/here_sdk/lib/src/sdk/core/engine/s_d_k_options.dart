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







/// Configuration of the SDK.
///
/// SDKOptions provide an alternative way to set or update the HERE SDK credentials at runtime to
/// initialize the [SDKNativeEngine].
/// [SDKOptions] fields can also be set via application .

class SDKOptions {
  /// Key used for authentication.
  String accessKeyId;

  /// Secret used for authentication.
  String accessKeySecret;

  /// Path to be used for caching purposes. If it is not set, the default path will be used
  /// `<Application_Home>/Library/Caches` - for IOS
  /// `Context.getCacheDir().getPath()` - for android
  String cachePath;

  /// Desired upper bound of application size in bytes. When cached data exceeds cache_size, least recently used data will be removed.
  /// Default value 256MB
  int cacheSizeInBytes;

  /// Path to store persistent map.  If it is not set, the default path will be used
  /// `Application Library directory` - for IOS
  /// `Context.getFilesDir().getPath()` - for android
  String persistentMapStoragePath;

  /// Political view of country, three letter country code defined by ISO 3166-1 alpha-3
  /// When set, all map data will respect point of view of this country
  /// NOTE: Leave it empty for international view
  /// This is a BETA feature and thus there can be bugs and unexpected behavior.
  String politicalView;

  /// Desired policy of using online connectivity.
  /// Default value False
  /// @nodoc
  bool internalofflineMode;

  SDKOptions._(this.accessKeyId, this.accessKeySecret, this.cachePath, this.cacheSizeInBytes, this.persistentMapStoragePath, this.politicalView, this.internalofflineMode);
  /// Constructs a SDKOptions from access key id.
  ///
  /// Other fields are filled with default values.
  ///
  /// [accessKeyId] Key used for authentication.
  ///
  factory SDKOptions.make(String accessKeyId) => $prototype.make(accessKeyId);
  /// Constructs a SDKOptions from access key id and secret.
  ///
  /// Other fields are filled with default values.
  ///
  /// [accessKeyId] Key used for authentication.
  ///
  /// [accessKeySecret] Secret used for authentication.
  ///
  factory SDKOptions.withAccessKeySecret(String accessKeyId, String accessKeySecret) => $prototype.withAccessKeySecret(accessKeyId, accessKeySecret);
  /// Constructs a SDKOptions from access key id, access key secret and cache_path.
  ///
  /// [accessKeyId] Key used for authentication.
  ///
  /// [accessKeySecret] Secret used for authentication.
  ///
  /// [cachePath] Path to be used for caching purposes. If it is not set,
  ///
  /// is set by default.
  ///
  factory SDKOptions.withAccessKeySecretAndCachePath(String accessKeyId, String accessKeySecret, String cachePath) => $prototype.withAccessKeySecretAndCachePath(accessKeyId, accessKeySecret, cachePath);
  /// Constructs a SDKOptions from access key id, access key secret, cache_path and cache_size.
  ///
  /// [accessKeyId] Key used for authentication.
  ///
  /// [accessKeySecret] Secret used for authentication.
  ///
  /// [cachePath] Path to be used for caching purposes. If it is not set,
  ///
  /// is set by default.
  ///
  /// [cacheSizeInBytes] Desired upper bound of application size in bytes.
  /// When cached data exceeds cache_size, least recently used data will be removed. Default value 256MB.
  ///
  factory SDKOptions.withAccessKeySecretAndCachePathCacheSize(String accessKeyId, String accessKeySecret, String cachePath, int cacheSizeInBytes) => $prototype.withAccessKeySecretAndCachePathCacheSize(accessKeyId, accessKeySecret, cachePath, cacheSizeInBytes);
  /// Constructs a SDKOptions from access key id, access key secret, cache_path, cache_size and persistent_map_storage_path.
  ///
  /// [accessKeyId] Key used for authentication.
  ///
  /// [accessKeySecret] Secret used for authentication.
  ///
  /// [cachePath] Path to be used for caching purposes. If it is not set,
  ///
  /// is set by default.
  ///
  /// [cacheSizeInBytes] Desired upper bound of application size in bytes.
  /// When cached data exceeds cache_size, least recently used data will be removed. Default value 256MB
  ///
  /// [persistentMapStoragePath] Path to store persistent map downloaded by MapDownloader. If it is not set,
  /// is set by default.
  /// Note: The MapDownloader is not available for the Lite and Explore Edition. For these two editions, this property has no effect and can be ignored.
  ///
  factory SDKOptions.withAccessKeySecretAndCachePathCacheSizeAndPersistentMapPath(String accessKeyId, String accessKeySecret, String cachePath, int cacheSizeInBytes, String persistentMapStoragePath) => $prototype.withAccessKeySecretAndCachePathCacheSizeAndPersistentMapPath(accessKeyId, accessKeySecret, cachePath, cacheSizeInBytes, persistentMapStoragePath);
  /// Constructs a SDKOptions from access key id, access key secret, cache_path, cache_size and persistent_map_storage_path.
  ///
  /// [accessKeyId] Key used for authentication.
  ///
  /// [accessKeySecret] Secret used for authentication.
  ///
  /// [cachePath] Path to be used for caching purposes. If it is not set,
  ///
  /// is set by default.
  ///
  /// [cacheSizeInBytes] Desired upper bound of application size in bytes.
  /// When cached data exceeds cache_size, least recently used data will be removed. Default value 256MB
  ///
  /// [persistentMapStoragePath] Path to store persistent map downloaded by MapDownloader. If it is not set,
  /// is set by default.
  ///
  /// [politicalView] // Political view for country, defined by ISO 3166-1 alpha-3 code.
  /// This is a BETA feature and thus there can be bugs and unexpected behavior.
  /// Note: The MapDownloader is not available for the Lite and Explore Edition. For these two editions, this property has no effect and can be ignored.
  ///
  factory SDKOptions.withAccessKeySecretAndCachePathCacheSizeAndPersistentMapPathAndPoliticalView(String accessKeyId, String accessKeySecret, String cachePath, int cacheSizeInBytes, String persistentMapStoragePath, String politicalView) => $prototype.withAccessKeySecretAndCachePathCacheSizeAndPersistentMapPathAndPoliticalView(accessKeyId, accessKeySecret, cachePath, cacheSizeInBytes, persistentMapStoragePath, politicalView);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SDKOptions) return false;
    SDKOptions _other = other;
    return accessKeyId == _other.accessKeyId &&
        accessKeySecret == _other.accessKeySecret &&
        cachePath == _other.cachePath &&
        cacheSizeInBytes == _other.cacheSizeInBytes &&
        persistentMapStoragePath == _other.persistentMapStoragePath &&
        politicalView == _other.politicalView &&
        internalofflineMode == _other.internalofflineMode;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + accessKeyId.hashCode;
    result = 31 * result + accessKeySecret.hashCode;
    result = 31 * result + cachePath.hashCode;
    result = 31 * result + cacheSizeInBytes.hashCode;
    result = 31 * result + persistentMapStoragePath.hashCode;
    result = 31 * result + politicalView.hashCode;
    result = 31 * result + internalofflineMode.hashCode;
    return result;
  }

  /// @nodoc
  @visibleForTesting
  static dynamic $prototype = SDKOptions$Impl();
}


// SDKOptions "private" section, not exported.

final _sdkCoreEngineSdkoptionsCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Int64, Pointer<Void>, Pointer<Void>, Uint8),
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, int, Pointer<Void>, Pointer<Void>, int)
  >('here_sdk_sdk_core_engine_SDKOptions_create_handle'));
final _sdkCoreEngineSdkoptionsReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_engine_SDKOptions_release_handle'));
final _sdkCoreEngineSdkoptionsGetFieldaccessKeyId = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_engine_SDKOptions_get_field_accessKeyId'));
final _sdkCoreEngineSdkoptionsGetFieldaccessKeySecret = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_engine_SDKOptions_get_field_accessKeySecret'));
final _sdkCoreEngineSdkoptionsGetFieldcachePath = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_engine_SDKOptions_get_field_cachePath'));
final _sdkCoreEngineSdkoptionsGetFieldcacheSizeInBytes = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Int64 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_core_engine_SDKOptions_get_field_cacheSizeInBytes'));
final _sdkCoreEngineSdkoptionsGetFieldpersistentMapStoragePath = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_engine_SDKOptions_get_field_persistentMapStoragePath'));
final _sdkCoreEngineSdkoptionsGetFieldpoliticalView = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_engine_SDKOptions_get_field_politicalView'));
final _sdkCoreEngineSdkoptionsGetFieldofflineMode = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint8 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_core_engine_SDKOptions_get_field_offlineMode'));



/// @nodoc
@visibleForTesting
class SDKOptions$Impl {
  SDKOptions make(String accessKeyId) {
    final _makeFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32, Pointer<Void>), Pointer<Void> Function(int, Pointer<Void>)>('here_sdk_sdk_core_engine_SDKOptions_make__String'));
    final _accessKeyIdHandle = stringToFfi(accessKeyId);
    final __resultHandle = _makeFfi(__lib.LibraryContext.isolateId, _accessKeyIdHandle);
    stringReleaseFfiHandle(_accessKeyIdHandle);
    try {
      return sdkCoreEngineSdkoptionsFromFfi(__resultHandle);
    } finally {
      sdkCoreEngineSdkoptionsReleaseFfiHandle(__resultHandle);

    }

  }

  SDKOptions withAccessKeySecret(String accessKeyId, String accessKeySecret) {
    final _withAccessKeySecretFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32, Pointer<Void>, Pointer<Void>), Pointer<Void> Function(int, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_core_engine_SDKOptions_make__String_String'));
    final _accessKeyIdHandle = stringToFfi(accessKeyId);
    final _accessKeySecretHandle = stringToFfi(accessKeySecret);
    final __resultHandle = _withAccessKeySecretFfi(__lib.LibraryContext.isolateId, _accessKeyIdHandle, _accessKeySecretHandle);
    stringReleaseFfiHandle(_accessKeyIdHandle);
    stringReleaseFfiHandle(_accessKeySecretHandle);
    try {
      return sdkCoreEngineSdkoptionsFromFfi(__resultHandle);
    } finally {
      sdkCoreEngineSdkoptionsReleaseFfiHandle(__resultHandle);

    }

  }

  SDKOptions withAccessKeySecretAndCachePath(String accessKeyId, String accessKeySecret, String cachePath) {
    final _withAccessKeySecretAndCachePathFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32, Pointer<Void>, Pointer<Void>, Pointer<Void>), Pointer<Void> Function(int, Pointer<Void>, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_core_engine_SDKOptions_make__String_String_String'));
    final _accessKeyIdHandle = stringToFfi(accessKeyId);
    final _accessKeySecretHandle = stringToFfi(accessKeySecret);
    final _cachePathHandle = stringToFfi(cachePath);
    final __resultHandle = _withAccessKeySecretAndCachePathFfi(__lib.LibraryContext.isolateId, _accessKeyIdHandle, _accessKeySecretHandle, _cachePathHandle);
    stringReleaseFfiHandle(_accessKeyIdHandle);
    stringReleaseFfiHandle(_accessKeySecretHandle);
    stringReleaseFfiHandle(_cachePathHandle);
    try {
      return sdkCoreEngineSdkoptionsFromFfi(__resultHandle);
    } finally {
      sdkCoreEngineSdkoptionsReleaseFfiHandle(__resultHandle);

    }

  }

  SDKOptions withAccessKeySecretAndCachePathCacheSize(String accessKeyId, String accessKeySecret, String cachePath, int cacheSizeInBytes) {
    final _withAccessKeySecretAndCachePathCacheSizeFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32, Pointer<Void>, Pointer<Void>, Pointer<Void>, Int64), Pointer<Void> Function(int, Pointer<Void>, Pointer<Void>, Pointer<Void>, int)>('here_sdk_sdk_core_engine_SDKOptions_make__String_String_String_Long'));
    final _accessKeyIdHandle = stringToFfi(accessKeyId);
    final _accessKeySecretHandle = stringToFfi(accessKeySecret);
    final _cachePathHandle = stringToFfi(cachePath);
    final _cacheSizeInBytesHandle = (cacheSizeInBytes);
    final __resultHandle = _withAccessKeySecretAndCachePathCacheSizeFfi(__lib.LibraryContext.isolateId, _accessKeyIdHandle, _accessKeySecretHandle, _cachePathHandle, _cacheSizeInBytesHandle);
    stringReleaseFfiHandle(_accessKeyIdHandle);
    stringReleaseFfiHandle(_accessKeySecretHandle);
    stringReleaseFfiHandle(_cachePathHandle);

    try {
      return sdkCoreEngineSdkoptionsFromFfi(__resultHandle);
    } finally {
      sdkCoreEngineSdkoptionsReleaseFfiHandle(__resultHandle);

    }

  }

  SDKOptions withAccessKeySecretAndCachePathCacheSizeAndPersistentMapPath(String accessKeyId, String accessKeySecret, String cachePath, int cacheSizeInBytes, String persistentMapStoragePath) {
    final _withAccessKeySecretAndCachePathCacheSizeAndPersistentMapPathFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32, Pointer<Void>, Pointer<Void>, Pointer<Void>, Int64, Pointer<Void>), Pointer<Void> Function(int, Pointer<Void>, Pointer<Void>, Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_core_engine_SDKOptions_make__String_String_String_Long_String'));
    final _accessKeyIdHandle = stringToFfi(accessKeyId);
    final _accessKeySecretHandle = stringToFfi(accessKeySecret);
    final _cachePathHandle = stringToFfi(cachePath);
    final _cacheSizeInBytesHandle = (cacheSizeInBytes);
    final _persistentMapStoragePathHandle = stringToFfi(persistentMapStoragePath);
    final __resultHandle = _withAccessKeySecretAndCachePathCacheSizeAndPersistentMapPathFfi(__lib.LibraryContext.isolateId, _accessKeyIdHandle, _accessKeySecretHandle, _cachePathHandle, _cacheSizeInBytesHandle, _persistentMapStoragePathHandle);
    stringReleaseFfiHandle(_accessKeyIdHandle);
    stringReleaseFfiHandle(_accessKeySecretHandle);
    stringReleaseFfiHandle(_cachePathHandle);

    stringReleaseFfiHandle(_persistentMapStoragePathHandle);
    try {
      return sdkCoreEngineSdkoptionsFromFfi(__resultHandle);
    } finally {
      sdkCoreEngineSdkoptionsReleaseFfiHandle(__resultHandle);

    }

  }

  SDKOptions withAccessKeySecretAndCachePathCacheSizeAndPersistentMapPathAndPoliticalView(String accessKeyId, String accessKeySecret, String cachePath, int cacheSizeInBytes, String persistentMapStoragePath, String politicalView) {
    final _withAccessKeySecretAndCachePathCacheSizeAndPersistentMapPathAndPoliticalViewFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32, Pointer<Void>, Pointer<Void>, Pointer<Void>, Int64, Pointer<Void>, Pointer<Void>), Pointer<Void> Function(int, Pointer<Void>, Pointer<Void>, Pointer<Void>, int, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_core_engine_SDKOptions_make__String_String_String_Long_String_String'));
    final _accessKeyIdHandle = stringToFfi(accessKeyId);
    final _accessKeySecretHandle = stringToFfi(accessKeySecret);
    final _cachePathHandle = stringToFfi(cachePath);
    final _cacheSizeInBytesHandle = (cacheSizeInBytes);
    final _persistentMapStoragePathHandle = stringToFfi(persistentMapStoragePath);
    final _politicalViewHandle = stringToFfi(politicalView);
    final __resultHandle = _withAccessKeySecretAndCachePathCacheSizeAndPersistentMapPathAndPoliticalViewFfi(__lib.LibraryContext.isolateId, _accessKeyIdHandle, _accessKeySecretHandle, _cachePathHandle, _cacheSizeInBytesHandle, _persistentMapStoragePathHandle, _politicalViewHandle);
    stringReleaseFfiHandle(_accessKeyIdHandle);
    stringReleaseFfiHandle(_accessKeySecretHandle);
    stringReleaseFfiHandle(_cachePathHandle);

    stringReleaseFfiHandle(_persistentMapStoragePathHandle);
    stringReleaseFfiHandle(_politicalViewHandle);
    try {
      return sdkCoreEngineSdkoptionsFromFfi(__resultHandle);
    } finally {
      sdkCoreEngineSdkoptionsReleaseFfiHandle(__resultHandle);

    }

  }

}

Pointer<Void> sdkCoreEngineSdkoptionsToFfi(SDKOptions value) {
  final _accessKeyIdHandle = stringToFfi(value.accessKeyId);
  final _accessKeySecretHandle = stringToFfi(value.accessKeySecret);
  final _cachePathHandle = stringToFfi(value.cachePath);
  final _cacheSizeInBytesHandle = (value.cacheSizeInBytes);
  final _persistentMapStoragePathHandle = stringToFfi(value.persistentMapStoragePath);
  final _politicalViewHandle = stringToFfi(value.politicalView);
  final _offlineModeHandle = booleanToFfi(value.internalofflineMode);
  final _result = _sdkCoreEngineSdkoptionsCreateHandle(_accessKeyIdHandle, _accessKeySecretHandle, _cachePathHandle, _cacheSizeInBytesHandle, _persistentMapStoragePathHandle, _politicalViewHandle, _offlineModeHandle);
  stringReleaseFfiHandle(_accessKeyIdHandle);
  stringReleaseFfiHandle(_accessKeySecretHandle);
  stringReleaseFfiHandle(_cachePathHandle);
  
  stringReleaseFfiHandle(_persistentMapStoragePathHandle);
  stringReleaseFfiHandle(_politicalViewHandle);
  booleanReleaseFfiHandle(_offlineModeHandle);
  return _result;
}

SDKOptions sdkCoreEngineSdkoptionsFromFfi(Pointer<Void> handle) {
  final _accessKeyIdHandle = _sdkCoreEngineSdkoptionsGetFieldaccessKeyId(handle);
  final _accessKeySecretHandle = _sdkCoreEngineSdkoptionsGetFieldaccessKeySecret(handle);
  final _cachePathHandle = _sdkCoreEngineSdkoptionsGetFieldcachePath(handle);
  final _cacheSizeInBytesHandle = _sdkCoreEngineSdkoptionsGetFieldcacheSizeInBytes(handle);
  final _persistentMapStoragePathHandle = _sdkCoreEngineSdkoptionsGetFieldpersistentMapStoragePath(handle);
  final _politicalViewHandle = _sdkCoreEngineSdkoptionsGetFieldpoliticalView(handle);
  final _offlineModeHandle = _sdkCoreEngineSdkoptionsGetFieldofflineMode(handle);
  try {
    return SDKOptions._(
      stringFromFfi(_accessKeyIdHandle), 
      stringFromFfi(_accessKeySecretHandle), 
      stringFromFfi(_cachePathHandle), 
      (_cacheSizeInBytesHandle), 
      stringFromFfi(_persistentMapStoragePathHandle), 
      stringFromFfi(_politicalViewHandle), 
      booleanFromFfi(_offlineModeHandle)
    );
  } finally {
    stringReleaseFfiHandle(_accessKeyIdHandle);
    stringReleaseFfiHandle(_accessKeySecretHandle);
    stringReleaseFfiHandle(_cachePathHandle);
    
    stringReleaseFfiHandle(_persistentMapStoragePathHandle);
    stringReleaseFfiHandle(_politicalViewHandle);
    booleanReleaseFfiHandle(_offlineModeHandle);
  }
}

void sdkCoreEngineSdkoptionsReleaseFfiHandle(Pointer<Void> handle) => _sdkCoreEngineSdkoptionsReleaseHandle(handle);

// Nullable SDKOptions

final _sdkCoreEngineSdkoptionsCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_engine_SDKOptions_create_handle_nullable'));
final _sdkCoreEngineSdkoptionsReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_engine_SDKOptions_release_handle_nullable'));
final _sdkCoreEngineSdkoptionsGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_engine_SDKOptions_get_value_nullable'));

Pointer<Void> sdkCoreEngineSdkoptionsToFfiNullable(SDKOptions? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkCoreEngineSdkoptionsToFfi(value);
  final result = _sdkCoreEngineSdkoptionsCreateHandleNullable(_handle);
  sdkCoreEngineSdkoptionsReleaseFfiHandle(_handle);
  return result;
}

SDKOptions? sdkCoreEngineSdkoptionsFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkCoreEngineSdkoptionsGetValueNullable(handle);
  final result = sdkCoreEngineSdkoptionsFromFfi(_handle);
  sdkCoreEngineSdkoptionsReleaseFfiHandle(_handle);
  return result;
}

void sdkCoreEngineSdkoptionsReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkCoreEngineSdkoptionsReleaseHandleNullable(handle);

// End of SDKOptions "private" section.

