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
import 'package:here_sdk/src/_native_base.dart' as __lib;
import 'package:here_sdk/src/_token_cache.dart' as __lib;
import 'package:here_sdk/src/sdk/core/language_code.dart';

/// internal class wrapping HARP's map context
/// @nodoc
abstract class MapContext {

  /// @nodoc
  @Deprecated("Does nothing")
  void release();

  /// Pauses the map context.
  ///
  /// @nodoc
  void internalpause();
  /// Resumes the map context.
  ///
  /// @nodoc
  void internalresume();
  /// Start to batch multiple compatible map view operations into one frame.
  ///
  /// The modifications
  /// will be applied by calling [MapContext.applyBatch]. If a batch was started and not applied yet a call
  /// to this method has no effect.
  ///
  /// @nodoc
  void internalstartBatch();
  /// Applies the operations which have been batched since calling [MapContext.startBatch].
  ///
  /// @nodoc
  void internalapplyBatch();
  /// @nodoc
  LanguageCode? get internalprimaryLanguage;
  /// @nodoc
  set internalprimaryLanguage(LanguageCode? value);

}


// MapContext "private" section, not exported.

final _sdkMapviewMapcontextRegisterFinalizer = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>, Int32, Handle),
    void Function(Pointer<Void>, int, Object)
  >('here_sdk_sdk_mapview_MapContext_register_finalizer'));
final _sdkMapviewMapcontextCopyHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapContext_copy_handle'));
final _sdkMapviewMapcontextReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapContext_release_handle'));






class MapContext$Impl extends __lib.NativeBase implements MapContext {

  MapContext$Impl(Pointer<Void> handle) : super(handle);

  @override
  void release() {}

  @override
  void internalpause() {
    final _pauseFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32), void Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapContext_pause'));
    final _handle = this.handle;
    _pauseFfi(_handle, __lib.LibraryContext.isolateId);

  }

  @override
  void internalresume() {
    final _resumeFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32), void Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapContext_resume'));
    final _handle = this.handle;
    _resumeFfi(_handle, __lib.LibraryContext.isolateId);

  }

  @override
  void internalstartBatch() {
    final _startBatchFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32), void Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapContext_startBatch'));
    final _handle = this.handle;
    _startBatchFfi(_handle, __lib.LibraryContext.isolateId);

  }

  @override
  void internalapplyBatch() {
    final _applyBatchFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32), void Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapContext_applyBatch'));
    final _handle = this.handle;
    _applyBatchFfi(_handle, __lib.LibraryContext.isolateId);

  }

  @override
  LanguageCode? get internalprimaryLanguage {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Pointer<Void>, Int32), Pointer<Void> Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapContext_primaryLanguage_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return sdkCoreLanguagecodeFromFfiNullable(__resultHandle);
    } finally {
      sdkCoreLanguagecodeReleaseFfiHandleNullable(__resultHandle);

    }

  }

  @override
  set internalprimaryLanguage(LanguageCode? value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapContext_primaryLanguage_set__LanguageCode_'));
    final _valueHandle = sdkCoreLanguagecodeToFfiNullable(value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);
    sdkCoreLanguagecodeReleaseFfiHandleNullable(_valueHandle);

  }



}

Pointer<Void> sdkMapviewMapcontextToFfi(MapContext value) =>
  _sdkMapviewMapcontextCopyHandle((value as __lib.NativeBase).handle);

MapContext sdkMapviewMapcontextFromFfi(Pointer<Void> handle) {
  final instance = __lib.getCachedInstance(handle);
  if (instance != null && instance is MapContext) return instance;

  final _copiedHandle = _sdkMapviewMapcontextCopyHandle(handle);
  final result = MapContext$Impl(_copiedHandle);
  __lib.cacheInstance(_copiedHandle, result);
  _sdkMapviewMapcontextRegisterFinalizer(_copiedHandle, __lib.LibraryContext.isolateId, result);
  return result;
}

void sdkMapviewMapcontextReleaseFfiHandle(Pointer<Void> handle) =>
  _sdkMapviewMapcontextReleaseHandle(handle);

Pointer<Void> sdkMapviewMapcontextToFfiNullable(MapContext? value) =>
  value != null ? sdkMapviewMapcontextToFfi(value) : Pointer<Void>.fromAddress(0);

MapContext? sdkMapviewMapcontextFromFfiNullable(Pointer<Void> handle) =>
  handle.address != 0 ? sdkMapviewMapcontextFromFfi(handle) : null;

void sdkMapviewMapcontextReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkMapviewMapcontextReleaseHandle(handle);

// End of MapContext "private" section.

