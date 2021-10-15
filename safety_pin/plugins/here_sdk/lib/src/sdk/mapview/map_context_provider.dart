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
import 'package:here_sdk/src/builtin_types__conversion.dart';
import 'package:here_sdk/src/generic_types__conversion.dart';
import 'package:here_sdk/src/sdk/mapview/map_context.dart';
import 'package:meta/meta.dart';

/// @nodoc
abstract class MapContextProvider {

  /// @nodoc
  @Deprecated("Does nothing")
  void release();

  /// Sets file paths to SDK resources needed for initialisation.
  ///
  /// [paths] The list of file paths with SDK resources.
  ///
  /// @nodoc
  static void internalsetInitResourcePaths(List<String> paths) => $prototype.internalsetInitResourcePaths(paths);
  /// Sets window render target to be used in creation of MapContext.
  ///
  /// [windowHandle] Native window handle.
  ///
  /// @nodoc
  static void internalsetInitWindowRenderTarget(int windowHandle) => $prototype.internalsetInitWindowRenderTarget(windowHandle);
  /// Sets graphics context to be used in creation of MapContext.
  ///
  /// [context] Graphics context handle.
  ///
  /// @nodoc
  static void internalsetInitGraphicsContext(int context) => $prototype.internalsetInitGraphicsContext(context);

  /// @nodoc
  static void internalsetInitEnableUserControlledRenderLoop(bool userLoopEnabled) => $prototype.internalsetInitEnableUserControlledRenderLoop(userLoopEnabled);
  /// Gets the map context.
  ///
  /// Creates one if necessary (when called for the first time
  /// or after a call to destroy()).
  ///
  /// @nodoc
  static MapContext? internalgetInstance() => $prototype.internalgetInstance();
  /// Destroys the map context.
  ///
  /// The instance is not usable after this point, get a new one
  /// with get_instance() if needed.
  ///
  /// @nodoc
  static void internaldestroy() => $prototype.internaldestroy();

  /// @nodoc
  @visibleForTesting
  static dynamic $prototype = MapContextProvider$Impl(Pointer<Void>.fromAddress(0));
}


// MapContextProvider "private" section, not exported.

final _sdkMapviewMapcontextproviderRegisterFinalizer = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>, Int32, Handle),
    void Function(Pointer<Void>, int, Object)
  >('here_sdk_sdk_mapview_MapContextProvider_register_finalizer'));
final _sdkMapviewMapcontextproviderCopyHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapContextProvider_copy_handle'));
final _sdkMapviewMapcontextproviderReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapContextProvider_release_handle'));








/// @nodoc
@visibleForTesting
class MapContextProvider$Impl extends __lib.NativeBase implements MapContextProvider {

  MapContextProvider$Impl(Pointer<Void> handle) : super(handle);

  @override
  void release() {}

  void internalsetInitResourcePaths(List<String> paths) {
    final _setInitResourcePathsFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Int32, Pointer<Void>), void Function(int, Pointer<Void>)>('here_sdk_sdk_mapview_MapContextProvider_setInitResourcePaths__ListOf_String'));
    final _pathsHandle = heresdkMapviewCommonBindingslistofStringToFfi(paths);
    _setInitResourcePathsFfi(__lib.LibraryContext.isolateId, _pathsHandle);
    heresdkMapviewCommonBindingslistofStringReleaseFfiHandle(_pathsHandle);

  }

  void internalsetInitWindowRenderTarget(int windowHandle) {
    final _setInitWindowRenderTargetFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Int32, Uint64), void Function(int, int)>('here_sdk_sdk_mapview_MapContextProvider_setInitWindowRenderTarget__ULong'));
    final _windowHandleHandle = (windowHandle);
    _setInitWindowRenderTargetFfi(__lib.LibraryContext.isolateId, _windowHandleHandle);


  }

  void internalsetInitGraphicsContext(int context) {
    final _setInitGraphicsContextFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Int32, Uint64), void Function(int, int)>('here_sdk_sdk_mapview_MapContextProvider_setInitGraphicsContext__ULong'));
    final _contextHandle = (context);
    _setInitGraphicsContextFfi(__lib.LibraryContext.isolateId, _contextHandle);


  }

  void internalsetInitEnableUserControlledRenderLoop(bool userLoopEnabled) {
    final _setInitEnableUserControlledRenderLoopFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Int32, Uint8), void Function(int, int)>('here_sdk_sdk_mapview_MapContextProvider_setInitEnableUserControlledRenderLoop__Boolean'));
    final _userLoopEnabledHandle = booleanToFfi(userLoopEnabled);
    _setInitEnableUserControlledRenderLoopFfi(__lib.LibraryContext.isolateId, _userLoopEnabledHandle);
    booleanReleaseFfiHandle(_userLoopEnabledHandle);

  }

  MapContext? internalgetInstance() {
    final _getInstanceFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32), Pointer<Void> Function(int)>('here_sdk_sdk_mapview_MapContextProvider_getInstance'));
    final __resultHandle = _getInstanceFfi(__lib.LibraryContext.isolateId);
    try {
      return sdkMapviewMapcontextFromFfiNullable(__resultHandle);
    } finally {
      sdkMapviewMapcontextReleaseFfiHandleNullable(__resultHandle);

    }

  }

  void internaldestroy() {
    final _destroyFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Int32), void Function(int)>('here_sdk_sdk_mapview_MapContextProvider_destroy'));
    _destroyFfi(__lib.LibraryContext.isolateId);

  }


}

Pointer<Void> sdkMapviewMapcontextproviderToFfi(MapContextProvider value) =>
  _sdkMapviewMapcontextproviderCopyHandle((value as __lib.NativeBase).handle);

MapContextProvider sdkMapviewMapcontextproviderFromFfi(Pointer<Void> handle) {
  final instance = __lib.getCachedInstance(handle);
  if (instance != null && instance is MapContextProvider) return instance;

  final _copiedHandle = _sdkMapviewMapcontextproviderCopyHandle(handle);
  final result = MapContextProvider$Impl(_copiedHandle);
  __lib.cacheInstance(_copiedHandle, result);
  _sdkMapviewMapcontextproviderRegisterFinalizer(_copiedHandle, __lib.LibraryContext.isolateId, result);
  return result;
}

void sdkMapviewMapcontextproviderReleaseFfiHandle(Pointer<Void> handle) =>
  _sdkMapviewMapcontextproviderReleaseHandle(handle);

Pointer<Void> sdkMapviewMapcontextproviderToFfiNullable(MapContextProvider? value) =>
  value != null ? sdkMapviewMapcontextproviderToFfi(value) : Pointer<Void>.fromAddress(0);

MapContextProvider? sdkMapviewMapcontextproviderFromFfiNullable(Pointer<Void> handle) =>
  handle.address != 0 ? sdkMapviewMapcontextproviderFromFfi(handle) : null;

void sdkMapviewMapcontextproviderReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkMapviewMapcontextproviderReleaseHandle(handle);

// End of MapContextProvider "private" section.

