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
import 'package:here_sdk/src/sdk/core/geo_box.dart';
import 'package:here_sdk/src/sdk/core/geo_coordinates.dart';
import 'package:here_sdk/src/sdk/core/geo_orientation.dart';
import 'package:here_sdk/src/sdk/core/geo_orientation_update.dart';
import 'package:here_sdk/src/sdk/core/point2_d.dart';
import 'package:here_sdk/src/sdk/core/rectangle2_d.dart';
import 'package:here_sdk/src/sdk/mapview/map_camera_animation.dart';
import 'package:here_sdk/src/sdk/mapview/map_camera_limits.dart';
import 'package:here_sdk/src/sdk/mapview/map_camera_observer.dart';
import 'package:here_sdk/src/sdk/mapview/map_camera_update.dart';
import 'package:meta/meta.dart';

/// Represents the camera looking onto the map.
///
/// Each MapView instance has exactly one camera that is used to manipulate
/// the way the map is displayed.
///
/// Any method that modifies the state of the camera will be enqueued and the state
/// will only be updated after drawing the next frame.
abstract class MapCamera {
  /// @nodoc
  @Deprecated("Does nothing")
  void release();

  /// Cancels any ongoing camera animation
  ///
  void cancelAnimation();

  /// Adds an observer to this camera that will be notified on the main thread
  /// every time the map is redrawn with new camera parameters.
  ///
  /// Adding the same observer multiple times has no effect.
  ///
  /// [observer] The observer to add.
  ///
  void addObserver(MapCameraObserver observer);

  /// Removes the observer from the camera.
  ///
  /// Trying to remove an observer that is not
  /// currently registered has no effect.
  ///
  /// [observer] The observer to remove.
  ///
  void removeObserver(MapCameraObserver observer);

  /// Orbits the camera around a specified view point by increasing tilt and bearing by specified
  /// delta values.
  ///
  /// This command will be enqueued and new position will be set only
  /// after drawing the next frame.
  ///
  /// [delta] Camera orientation change, containing tilt and bearing angle deltas.
  ///
  /// [origin] Point in view coordinates around which orbiting occurs
  ///
  @Deprecated(
      "Will be removed in v4.10.0. Use [MapCamera.orbitByWithGeoOrientation] instead.")
  void orbitBy(MapCameraOrientationUpdate delta, Point2D origin);

  /// Orbits the camera around a specified view point by increasing tilt and bearing by specified
  /// delta values.
  ///
  /// This command will be enqueued and new position will be set only
  /// after drawing the next frame.
  ///
  /// [delta] Camera orientation change, containing tilt and bearing angle deltas.
  ///
  /// [origin] Point in view coordinates around which orbiting occurs
  ///
  void orbitByWithGeoOrientation(GeoOrientationUpdate delta, Point2D origin);

  /// Zooms in or out by a specified factor.
  ///
  /// This effectively changes the distance from the camera to the [MapCameraState.targetCoordinates]
  /// by the specified factor, which changes [MapCameraState.zoomLevel] as well.
  ///
  /// Values above 1.0 will zoom in and values below will zoom out.
  ///
  /// The relation with [MapCameraState.distanceToTargetInMeters] is inversely linear,
  /// meaning that zooming by 4 will decrease distance to target by 4 while zooming by 0.5
  /// will increase distance to target by 2.
  ///
  /// The relation with zoom level is exponential. Meaning that zooming by a factor of 4 will
  /// increase zoom level by 2 (because sqrt(4) == 2). So to zoom in by X zoom levels, the zoom
  /// factor needs to be 2^X. To zoom out by X zoom levels, zoom factor needs to be 1/(2^X).
  ///
  /// The zooming occurs around the specified origin inside the view.
  ///
  /// This command will be enqueued and new position will be set only
  /// after drawing the next frame.
  ///
  /// [factor] The zoom factor. Values above 1.0 will zoom in and values below will zoom out.
  ///
  /// [origin] Point in view coordinates around which zooming occurs
  ///
  void zoomBy(double factor, Point2D origin);

  /// Zooms to the specified zoom level.
  ///
  /// The supplied value will be clamped to the range
  /// of \[0, 22\], where 0 is a view of whole globe and 22 is street level.
  ///
  /// This effectively changes the distance from the camera to the target.
  /// The zooming occurs around the current target point.
  ///
  /// This command will be enqueued and new position will be set only
  /// after drawing the next frame.
  ///
  /// [zoomLevel] The zoom level to set, clamped to the range of \[0, 22\].
  ///
  void zoomTo(double zoomLevel);

  /// Applies camera update to the map camera.
  ///
  /// Update is enqueued and will be executed during processing of the next frame.
  ///
  /// [cameraUpdate] The update that gets applied to camera.
  ///
  void applyUpdate(MapCameraUpdate cameraUpdate);

  /// Starts a given camera animation.
  ///
  /// [cameraAnimation] The animation to be started.
  ///
  void startAnimation(MapCameraAnimation cameraAnimation);

  /// Makes the camera look at a new geodetic target, while
  /// preserving the current orientation and distance to the target.
  ///
  /// [target] Geodetic coordinates at which the camera will point.
  ///
  void lookAtPoint(GeoCoordinates target);

  /// Makes the camera look at the geodetic target from the given distance.
  ///
  /// [target] Geodetic coordinates at which the camera will point.
  ///
  /// [distanceInMeters] Distance in meters to the target point.
  ///
  void lookAtPointWithDistance(GeoCoordinates target, double distanceInMeters);

  /// Makes the camera look at the geodetic target from the given distance and orientation.
  ///
  /// The supplied orientation is the orientation of the camera looking
  /// at the target, so the resulting camera state will have the
  /// same orientation as the one supplied to this method.
  ///
  /// [target] Geodetic coordinates at which the camera will point.
  ///
  /// [orientation] Desired orientation of the camera.
  ///
  /// [distanceInMeters] Distance in meters to the target point.
  ///
  @Deprecated(
      "Will be removed in v4.10.0. Use [MapCamera.lookAtPointWithGeoOrientationAndDistance] instead.")
  void lookAtPointWithOrientationAndDistance(GeoCoordinates target,
      MapCameraOrientationUpdate orientation, double distanceInMeters);

  /// Makes the camera look at the geodetic target from the given distance and orientation.
  ///
  /// The supplied orientation is the orientation of the camera looking
  /// at the target, so the resulting camera state will have the
  /// same orientation as the one supplied to this method.
  ///
  /// [target] Geodetic coordinates at which the camera will point.
  ///
  /// [orientation] Desired orientation of the camera.
  ///
  /// [distanceInMeters] Distance in meters to the target point.
  ///
  void lookAtPointWithGeoOrientationAndDistance(GeoCoordinates target,
      GeoOrientationUpdate orientation, double distanceInMeters);

  /// Makes the camera look at the specified geodetic area.
  ///
  /// The supplied orientation is the orientation of the camera looking
  /// at the target, so the resulting camera state will have the
  /// same orientation as the one supplied to this method.
  ///
  /// [target] Geodetic area at which the camera will point
  ///
  /// [orientation] Desired orientation of the camera
  ///
  @Deprecated(
      "Will be removed in v4.10.0. Use [MapCamera.lookAtAreaWithGeoOrientation] instead.")
  void lookAtAreaWithOrientation(
      GeoBox target, MapCameraOrientationUpdate orientation);

  /// Makes the camera look at the specified geodetic area.
  ///
  /// The supplied orientation is the orientation of the camera looking
  /// at the target, so the resulting camera state will have the
  /// same orientation as the one supplied to this method.
  ///
  /// [target] Geodetic area at which the camera will point
  ///
  /// [orientation] Desired orientation of the camera
  ///
  void lookAtAreaWithGeoOrientation(
      GeoBox target, GeoOrientationUpdate orientation);

  /// Makes the camera look at current target from certain distance
  ///
  /// This function neither modifies target coordinates nor target orientation.
  ///
  /// [distanceInMeters] Distance in meters to the target point.
  /// Minimal distance value is clamped to 100 meters.
  ///
  void setDistanceToTarget(double distanceInMeters);

  /// Changes camera orientation in relation to target.
  ///
  /// This command will be enqueued and new position will be set only
  /// after drawing the next frame.
  ///
  /// [orientation] Desired orientation of the camera.
  ///
  @Deprecated(
      "Will be removed in v4.10.0. Use [MapCamera.setOrientationAtTarget] instead.")
  void setTargetOrientation(MapCameraOrientationUpdate orientation);

  /// Changes camera orientation in relation to target location.
  ///
  /// This command will be enqueued and new position will be set only
  /// after drawing the next frame.
  ///
  /// [orientation] Desired orientation of the camera.
  ///
  void setOrientationAtTarget(GeoOrientationUpdate orientation);

  /// Animates the camera to the new position along an adaptive ballistic curve.<br>
  /// The beginning and end of the animation will use the current [MapCameraState.distanceToTargetInMeters],
  /// and its value will change during the animation.
  ///
  /// Note: The animation can be interrupted by gestures or any programmatic change
  /// of the camera's position or orientation.
  ///
  /// [target] The coordinates of the new target point
  ///
  void flyTo(GeoCoordinates target);

  /// Animates the camera to the new position along a configurable adaptive ballistic curve.<br>
  /// The beginning and end of the animation will use the current [MapCameraState.distanceToTargetInMeters],
  /// and its value will change during the animation.
  ///
  /// Note: The animation can be interrupted by gestures or any programmatic change
  /// of the camera's position or orientation.
  ///
  /// [target] The coordinates of the new target point
  ///
  /// [animationOptions] The options of the ballistic curve.
  ///
  void flyToWithOptions(
      GeoCoordinates target, MapCameraFlyToOptions animationOptions);

  /// Animates the camera to the new position along a configurable adaptive ballistic curve.<br>
  /// Note: The animation can be interrupted by gestures or any programmatic change
  /// of the camera's position or orientation.
  ///
  /// [target] The coordinates of the destination point.
  ///
  /// [distanceInMeters] The distance to target at destination.
  ///
  /// [animationOptions] The options of the ballistic curve.
  ///
  void flyToWithOptionsAndDistance(GeoCoordinates target,
      double distanceInMeters, MapCameraFlyToOptions animationOptions);

  /// Animates the camera to the new position along a configurable adaptive ballistic curve.<br>
  /// Note: The animation can be interrupted by gestures or any programmatic change
  /// of the camera's position or orientation.
  ///
  /// [target] The coordinates of the destination point.
  ///
  /// [orientation] The orientation at destination.
  ///
  /// [animationOptions] The options of the ballistic curve.
  ///
  @Deprecated(
      "Will be removed in v4.10.0. Use [MapCamera.flyToWithOptionsAndGeoOrientation] instead.")
  void flyToWithOptionsAndOrientation(
      GeoCoordinates target,
      MapCameraOrientationUpdate orientation,
      MapCameraFlyToOptions animationOptions);

  /// Animates the camera to the new position along a configurable adaptive ballistic curve.<br>
  /// Note: The animation can be interrupted by gestures or any programmatic change
  /// of the camera's position or orientation.
  ///
  /// [target] The coordinates of the destination point.
  ///
  /// [orientation] The orientation at destination.
  ///
  /// [animationOptions] The options of the ballistic curve.
  ///
  void flyToWithOptionsAndGeoOrientation(GeoCoordinates target,
      GeoOrientationUpdate orientation, MapCameraFlyToOptions animationOptions);

  /// Animates the camera to the new position along a configurable adaptive ballistic curve.<br>
  /// Note: The animation can be interrupted by gestures or any programmatic change
  /// of the camera's position or orientation.
  ///
  /// [target] The coordinates of the destination point.
  ///
  /// [orientation] The orientation at destination.
  ///
  /// [distanceInMeters] The distance to target at destination.
  ///
  /// [animationOptions] The options of the ballistic curve.
  ///
  @Deprecated(
      "Will be removed in v4.10.0. Use [MapCamera.flyToWithOptionsAndGeoOrientationAndDistance] instead.")
  void flyToWithOptionsAndOrientationAndDistance(
      GeoCoordinates target,
      MapCameraOrientationUpdate orientation,
      double distanceInMeters,
      MapCameraFlyToOptions animationOptions);

  /// Animates the camera to the new position along a configurable adaptive ballistic curve.<br>
  /// Note: The animation can be interrupted by gestures or any programmatic change
  /// of the camera's position or orientation.
  ///
  /// [target] The coordinates of the destination point.
  ///
  /// [orientation] The orientation at destination.
  ///
  /// [distanceInMeters] The distance to target at destination.
  ///
  /// [animationOptions] The options of the ballistic curve.
  ///
  void flyToWithOptionsAndGeoOrientationAndDistance(
      GeoCoordinates target,
      GeoOrientationUpdate orientation,
      double distanceInMeters,
      MapCameraFlyToOptions animationOptions);

  /// Makes the camera look at the specified geodetic area and pass a rectangle which specifies
  /// where the area should appear inside of the map view.
  ///
  /// The supplied orientation is the orientation of the camera looking
  /// at the target, so the resulting camera state will have the
  /// same orientation as the one supplied to this method. Please note that
  /// the resulting orientation might deviate from the provided orientation.
  /// This is particularly the case if a large geobox on world level and a
  /// view rectangle which is relatively small was passed to the method.
  ///
  /// [target] Geodetic area which will be shown in the view_box
  ///
  /// [orientation] Desired orientation of the camera
  ///
  /// [viewRectangle] Defines the rectangle in view coordinates inside which the geographical target
  /// area is displayed.
  ///
  @Deprecated(
      "Will be removed in v4.10.0. Use [MapCamera.lookAtAreaWithGeoOrientationAndViewRectangle] instead.")
  void lookAtAreaWithOrientationAndViewRectangle(GeoBox target,
      MapCameraOrientationUpdate orientation, Rectangle2D viewRectangle);

  /// Makes the camera look at the specified geodetic area and pass a rectangle which specifies
  /// where the area should appear inside of the map view.
  ///
  /// The supplied orientation is the orientation of the camera looking
  /// at the target, so the resulting camera state will have the
  /// same orientation as the one supplied to this method. Please note that
  /// the resulting orientation might deviate from the provided orientation.
  /// This is particularly the case if a large geobox on world level and a
  /// view rectangle which is relatively small was passed to the method.
  ///
  /// [target] Geodetic area which will be shown in the view_box
  ///
  /// [orientation] Desired orientation of the camera
  ///
  /// [viewRectangle] The rectangle in view coordinates inside which the geographical target
  /// area is displayed
  ///
  void lookAtAreaWithGeoOrientationAndViewRectangle(GeoBox target,
      GeoOrientationUpdate orientation, Rectangle2D viewRectangle);

  /// @nodoc
  ///
  /// [target] Geodetic area which will be shown in the view_box
  ///
  /// [orientation] Desired orientation of the camera
  ///
  /// [viewRectangle] Defines the rectangle in view coordinates inside which the geographical target
  /// area is displayed.
  ///
  /// [durationInMs] Duration of the animation in milliseconds.
  ///
  @Deprecated(
      "Will be removed in v4.10.0. Use [MapCameraUpdateFactory.lookAtAreaWithGeoOrientationAndViewRectangle] + [MapCameraAnimationFactory.createAnimationFromUpdate] + [MapCamera.startAnimation] instead.")
  void animateToAreaWithOrientationAndViewRectangle(
      GeoBox target,
      MapCameraOrientationUpdate orientation,
      Rectangle2D viewRectangle,
      int durationInMs);

  /// @nodoc
  ///
  /// [target] Geodetic area which will be shown in the view_box
  ///
  /// [orientation] Desired orientation of the camera
  ///
  /// [viewRectangle] Defines the rectangle in view coordinates inside which the geographical target
  /// area is displayed.
  ///
  /// [durationInMs] Duration of the animation in milliseconds.
  ///
  @Deprecated(
      "Will be removed in v4.12.0. Use [MapCameraUpdateFactory.lookAtAreaWithGeoOrientationAndViewRectangle] + [MapCameraAnimationFactory.createAnimationFromUpdate] + [MapCamera.startAnimation] instead.")
  void animateToAreaWithGeoOrientationAndViewRectangle(
      GeoBox target,
      GeoOrientationUpdate orientation,
      Rectangle2D viewRectangle,
      int durationInMs);

  /// Gets state of the camera that reflects what is currently drawn inside the MapView.
  MapCameraState get state;

  /// Gets the current visible map area encompassed in a GeoBox.
  /// Note that this bounding box is always rectangular, and its sides are always
  /// parallel to the latitude and longitude. If the camera is rotated, the returned
  /// bounding box will be a circumscribed rectangle that is larger than the
  /// visible map area. Similarly, when the map is tilted (for example, if
  /// the map is tilted by 45 degrees), the visible map area represents
  /// a trapezoidal area in the world. Resulting value will then be a larger
  /// circumscribed rectangle that contains this trapezoid area.
  /// Because of this, corners of the resulting bounding box may be located
  /// outside of currently visible area.
  /// When the map area does not fully fill the viewport, `null` is returned.
  GeoBox? get boundingBox;

  /// Gets a MapCameraLimits instance that controls limits for the camera settings.
  MapCameraLimits get limits;

  /// Gets the point that determines where the target is placed within the map view.
  /// By default, the principal point is located at the center of the map view.
  ///
  /// The value of the principal point is adjusted when the dimensions of the
  /// map view change, so that it stays in the same point relative to width
  /// and height. Meaning that when a principal point it set to bottom
  /// middle of the map view, it will stay in the bottom middle regardless
  /// of the changes to dimensions and orientation of the view.
  Point2D get principalPoint;

  /// Sets the point that determines where the target appears within the map view.
  /// This instantly moves the map to render the current target coordinates
  /// at the new principal point.
  ///
  /// By default, the principal point is located at the center of the map view.
  /// It is set in pixels relative to the map view's origin top-left (0, 0).
  /// Values outside the map view's dimensions (x < 0 || x > width, y < 0 || y > height)
  /// will be rejected silently and the current principal point is kept.
  ///
  /// The value of the principal point is adjusted when the dimensions of the
  /// map view change, so that it stays in the same point relative to width
  /// and height. Meaning that when a principal point it set to bottom
  /// middle of the map view, it will stay in the bottom middle regardless
  /// of the changes to dimensions and orientation of the view.
  ///
  /// Note: The principal point affects all programmatical map transformations (rotate, orbit, tilt and zoom)
  /// and the two-finger-pan gesture to tilt the map. Other gestures, like pinch-rotate,
  /// are not affected.
  set principalPoint(Point2D value);
}

/// Specifies camera parameters that can be used to update the camera's orientation in geodetic coordinate space.
///
/// All uninitialized values will be ignored when applying this update information to the camera.
@Deprecated("Will be removed in v4.10.0. Use [GeoOrientationUpdate] instead.")
class MapCameraOrientationUpdate {
  /// Bearing in degrees, from the true North in clockwise direction.
  /// Bearing axis is perpendicular to the ground.
  /// Value will remain unchanged if set to .
  double? bearing;

  /// Tilt in degrees.
  /// Tilt axis is parallel to the ground.
  /// Value will remain unchanged if set to .
  double? tilt;

  MapCameraOrientationUpdate(this.bearing, this.tilt);
  MapCameraOrientationUpdate.withDefaults()
      : bearing = null,
        tilt = null;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MapCameraOrientationUpdate) return false;
    MapCameraOrientationUpdate _other = other;
    return bearing == _other.bearing && tilt == _other.tilt;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + bearing.hashCode;
    result = 31 * result + tilt.hashCode;
    return result;
  }
}

// MapCameraOrientationUpdate "private" section, not exported.

final _sdkMapviewMapcameraOrientationupdateCreateHandle =
    __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
            Pointer<Void> Function(Pointer<Void>, Pointer<Void>),
            Pointer<Void> Function(Pointer<Void>, Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_OrientationUpdate_create_handle'));
final _sdkMapviewMapcameraOrientationupdateReleaseHandle =
    __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
            Void Function(Pointer<Void>), void Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_OrientationUpdate_release_handle'));
final _sdkMapviewMapcameraOrientationupdateGetFieldbearing =
    __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
            Pointer<Void> Function(Pointer<Void>),
            Pointer<Void> Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_OrientationUpdate_get_field_bearing'));
final _sdkMapviewMapcameraOrientationupdateGetFieldtilt =
    __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
            Pointer<Void> Function(Pointer<Void>),
            Pointer<Void> Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_OrientationUpdate_get_field_tilt'));

Pointer<Void> sdkMapviewMapcameraOrientationupdateToFfi(
    MapCameraOrientationUpdate value) {
  final _bearingHandle = doubleToFfiNullable(value.bearing);
  final _tiltHandle = doubleToFfiNullable(value.tilt);
  final _result = _sdkMapviewMapcameraOrientationupdateCreateHandle(
      _bearingHandle, _tiltHandle);
  doubleReleaseFfiHandleNullable(_bearingHandle);
  doubleReleaseFfiHandleNullable(_tiltHandle);
  return _result;
}

MapCameraOrientationUpdate sdkMapviewMapcameraOrientationupdateFromFfi(
    Pointer<Void> handle) {
  final _bearingHandle =
      _sdkMapviewMapcameraOrientationupdateGetFieldbearing(handle);
  final _tiltHandle = _sdkMapviewMapcameraOrientationupdateGetFieldtilt(handle);
  try {
    return MapCameraOrientationUpdate(doubleFromFfiNullable(_bearingHandle),
        doubleFromFfiNullable(_tiltHandle));
  } finally {
    doubleReleaseFfiHandleNullable(_bearingHandle);
    doubleReleaseFfiHandleNullable(_tiltHandle);
  }
}

void sdkMapviewMapcameraOrientationupdateReleaseFfiHandle(
        Pointer<Void> handle) =>
    _sdkMapviewMapcameraOrientationupdateReleaseHandle(handle);

// Nullable MapCameraOrientationUpdate

final _sdkMapviewMapcameraOrientationupdateCreateHandleNullable =
    __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
            Pointer<Void> Function(Pointer<Void>),
            Pointer<Void> Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_OrientationUpdate_create_handle_nullable'));
final _sdkMapviewMapcameraOrientationupdateReleaseHandleNullable =
    __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
            Void Function(Pointer<Void>), void Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_OrientationUpdate_release_handle_nullable'));
final _sdkMapviewMapcameraOrientationupdateGetValueNullable =
    __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
            Pointer<Void> Function(Pointer<Void>),
            Pointer<Void> Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_OrientationUpdate_get_value_nullable'));

Pointer<Void> sdkMapviewMapcameraOrientationupdateToFfiNullable(
    MapCameraOrientationUpdate? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkMapviewMapcameraOrientationupdateToFfi(value);
  final result =
      _sdkMapviewMapcameraOrientationupdateCreateHandleNullable(_handle);
  sdkMapviewMapcameraOrientationupdateReleaseFfiHandle(_handle);
  return result;
}

MapCameraOrientationUpdate? sdkMapviewMapcameraOrientationupdateFromFfiNullable(
    Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkMapviewMapcameraOrientationupdateGetValueNullable(handle);
  final result = sdkMapviewMapcameraOrientationupdateFromFfi(_handle);
  sdkMapviewMapcameraOrientationupdateReleaseFfiHandle(_handle);
  return result;
}

void sdkMapviewMapcameraOrientationupdateReleaseFfiHandleNullable(
        Pointer<Void> handle) =>
    _sdkMapviewMapcameraOrientationupdateReleaseHandleNullable(handle);

// End of MapCameraOrientationUpdate "private" section.
/// Represents information on current camera orientation in geodetic coordinate space.
///
/// This data container is part of a [MapCameraState].
@Deprecated("Will be removed in v4.10.0. Use [GeoOrientation] instead.")
class MapCameraOrientation {
  /// Bearing in degrees, from the true North in clockwise direction.
  /// Bearing axis is perpendicular to the ground and passes through the target coordinate.
  double bearing;

  /// Tilt in degrees.
  /// Tilt axis is parallel to the ground and passes through the target coordinate.
  double tilt;

  MapCameraOrientation(this.bearing, this.tilt);
  MapCameraOrientation.withDefaults()
      : bearing = 0,
        tilt = 0;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MapCameraOrientation) return false;
    MapCameraOrientation _other = other;
    return bearing == _other.bearing && tilt == _other.tilt;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + bearing.hashCode;
    result = 31 * result + tilt.hashCode;
    return result;
  }
}

// MapCameraOrientation "private" section, not exported.

final _sdkMapviewMapcameraOrientationCreateHandle = __lib.catchArgumentError(
    () => __lib.nativeLibrary.lookupFunction<
            Pointer<Void> Function(Double, Double),
            Pointer<Void> Function(double, double)>(
        'here_sdk_sdk_mapview_MapCamera_Orientation_create_handle'));
final _sdkMapviewMapcameraOrientationReleaseHandle = __lib.catchArgumentError(
    () => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>),
            void Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_Orientation_release_handle'));
final _sdkMapviewMapcameraOrientationGetFieldbearing = __lib.catchArgumentError(
    () => __lib.nativeLibrary.lookupFunction<Double Function(Pointer<Void>),
            double Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_Orientation_get_field_bearing'));
final _sdkMapviewMapcameraOrientationGetFieldtilt = __lib.catchArgumentError(
    () => __lib.nativeLibrary.lookupFunction<Double Function(Pointer<Void>),
            double Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_Orientation_get_field_tilt'));

Pointer<Void> sdkMapviewMapcameraOrientationToFfi(MapCameraOrientation value) {
  final _bearingHandle = (value.bearing);
  final _tiltHandle = (value.tilt);
  final _result =
      _sdkMapviewMapcameraOrientationCreateHandle(_bearingHandle, _tiltHandle);

  return _result;
}

MapCameraOrientation sdkMapviewMapcameraOrientationFromFfi(
    Pointer<Void> handle) {
  final _bearingHandle = _sdkMapviewMapcameraOrientationGetFieldbearing(handle);
  final _tiltHandle = _sdkMapviewMapcameraOrientationGetFieldtilt(handle);
  try {
    return MapCameraOrientation((_bearingHandle), (_tiltHandle));
  } finally {}
}

void sdkMapviewMapcameraOrientationReleaseFfiHandle(Pointer<Void> handle) =>
    _sdkMapviewMapcameraOrientationReleaseHandle(handle);

// Nullable MapCameraOrientation

final _sdkMapviewMapcameraOrientationCreateHandleNullable =
    __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
            Pointer<Void> Function(Pointer<Void>),
            Pointer<Void> Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_Orientation_create_handle_nullable'));
final _sdkMapviewMapcameraOrientationReleaseHandleNullable =
    __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
            Void Function(Pointer<Void>), void Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_Orientation_release_handle_nullable'));
final _sdkMapviewMapcameraOrientationGetValueNullable =
    __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
            Pointer<Void> Function(Pointer<Void>),
            Pointer<Void> Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_Orientation_get_value_nullable'));

Pointer<Void> sdkMapviewMapcameraOrientationToFfiNullable(
    MapCameraOrientation? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkMapviewMapcameraOrientationToFfi(value);
  final result = _sdkMapviewMapcameraOrientationCreateHandleNullable(_handle);
  sdkMapviewMapcameraOrientationReleaseFfiHandle(_handle);
  return result;
}

MapCameraOrientation? sdkMapviewMapcameraOrientationFromFfiNullable(
    Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkMapviewMapcameraOrientationGetValueNullable(handle);
  final result = sdkMapviewMapcameraOrientationFromFfi(_handle);
  sdkMapviewMapcameraOrientationReleaseFfiHandle(_handle);
  return result;
}

void sdkMapviewMapcameraOrientationReleaseFfiHandleNullable(
        Pointer<Void> handle) =>
    _sdkMapviewMapcameraOrientationReleaseHandleNullable(handle);

// End of MapCameraOrientation "private" section.
/// Encapsulates state of the camera.

class MapCameraState {
  /// Camera's 'LookAt' target position in geodetic space.
  GeoCoordinates targetCoordinates;

  /// Camera's 'LookAt' target orientation in geodetic space.
  @Deprecated(
      "Will be removed in v4.10.0. Use [MapCameraState.orientationAtTarget] instead.")
  MapCameraOrientation targetOrientation;

  /// Camera's orientation at target point.
  GeoOrientation orientationAtTarget;

  /// Distance from the camera to the target point in meters.
  double distanceToTargetInMeters;

  /// Zoom level corresponding to the current distance to target.
  double zoomLevel;

  MapCameraState(this.targetCoordinates, this.targetOrientation,
      this.orientationAtTarget, this.distanceToTargetInMeters, this.zoomLevel);
}

// MapCameraState "private" section, not exported.

final _sdkMapviewMapcameraStateCreateHandle = __lib.catchArgumentError(() =>
    __lib.nativeLibrary.lookupFunction<
        Pointer<Void> Function(
            Pointer<Void>, Pointer<Void>, Pointer<Void>, Double, Double),
        Pointer<Void> Function(
            Pointer<Void>,
            Pointer<Void>,
            Pointer<Void>,
            double,
            double)>('here_sdk_sdk_mapview_MapCamera_State_create_handle'));
final _sdkMapviewMapcameraStateReleaseHandle = __lib.catchArgumentError(() =>
    __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>),
            void Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_State_release_handle'));
final _sdkMapviewMapcameraStateGetFieldtargetCoordinates =
    __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
            Pointer<Void> Function(Pointer<Void>),
            Pointer<Void> Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_State_get_field_targetCoordinates'));
final _sdkMapviewMapcameraStateGetFieldtargetOrientation =
    __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
            Pointer<Void> Function(Pointer<Void>),
            Pointer<Void> Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_State_get_field_targetOrientation'));
final _sdkMapviewMapcameraStateGetFieldorientationAtTarget =
    __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
            Pointer<Void> Function(Pointer<Void>),
            Pointer<Void> Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_State_get_field_orientationAtTarget'));
final _sdkMapviewMapcameraStateGetFielddistanceToTargetInMeters =
    __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
            Double Function(Pointer<Void>), double Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_State_get_field_distanceToTargetInMeters'));
final _sdkMapviewMapcameraStateGetFieldzoomLevel = __lib.catchArgumentError(
    () => __lib.nativeLibrary.lookupFunction<Double Function(Pointer<Void>),
            double Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_State_get_field_zoomLevel'));

Pointer<Void> sdkMapviewMapcameraStateToFfi(MapCameraState value) {
  final _targetCoordinatesHandle =
      sdkCoreGeocoordinatesToFfi(value.targetCoordinates);
  final _targetOrientationHandle =
      sdkMapviewMapcameraOrientationToFfi(value.targetOrientation);
  final _orientationAtTargetHandle =
      sdkCoreGeoorientationToFfi(value.orientationAtTarget);
  final _distanceToTargetInMetersHandle = (value.distanceToTargetInMeters);
  final _zoomLevelHandle = (value.zoomLevel);
  final _result = _sdkMapviewMapcameraStateCreateHandle(
      _targetCoordinatesHandle,
      _targetOrientationHandle,
      _orientationAtTargetHandle,
      _distanceToTargetInMetersHandle,
      _zoomLevelHandle);
  sdkCoreGeocoordinatesReleaseFfiHandle(_targetCoordinatesHandle);
  sdkMapviewMapcameraOrientationReleaseFfiHandle(_targetOrientationHandle);
  sdkCoreGeoorientationReleaseFfiHandle(_orientationAtTargetHandle);

  return _result;
}

MapCameraState sdkMapviewMapcameraStateFromFfi(Pointer<Void> handle) {
  final _targetCoordinatesHandle =
      _sdkMapviewMapcameraStateGetFieldtargetCoordinates(handle);
  final _targetOrientationHandle =
      _sdkMapviewMapcameraStateGetFieldtargetOrientation(handle);
  final _orientationAtTargetHandle =
      _sdkMapviewMapcameraStateGetFieldorientationAtTarget(handle);
  final _distanceToTargetInMetersHandle =
      _sdkMapviewMapcameraStateGetFielddistanceToTargetInMeters(handle);
  final _zoomLevelHandle = _sdkMapviewMapcameraStateGetFieldzoomLevel(handle);
  try {
    return MapCameraState(
        sdkCoreGeocoordinatesFromFfi(_targetCoordinatesHandle),
        sdkMapviewMapcameraOrientationFromFfi(_targetOrientationHandle),
        sdkCoreGeoorientationFromFfi(_orientationAtTargetHandle),
        (_distanceToTargetInMetersHandle),
        (_zoomLevelHandle));
  } finally {
    sdkCoreGeocoordinatesReleaseFfiHandle(_targetCoordinatesHandle);
    sdkMapviewMapcameraOrientationReleaseFfiHandle(_targetOrientationHandle);
    sdkCoreGeoorientationReleaseFfiHandle(_orientationAtTargetHandle);
  }
}

void sdkMapviewMapcameraStateReleaseFfiHandle(Pointer<Void> handle) =>
    _sdkMapviewMapcameraStateReleaseHandle(handle);

// Nullable MapCameraState

final _sdkMapviewMapcameraStateCreateHandleNullable = __lib.catchArgumentError(
    () => __lib.nativeLibrary.lookupFunction<
            Pointer<Void> Function(Pointer<Void>),
            Pointer<Void> Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_State_create_handle_nullable'));
final _sdkMapviewMapcameraStateReleaseHandleNullable = __lib.catchArgumentError(
    () => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>),
            void Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_State_release_handle_nullable'));
final _sdkMapviewMapcameraStateGetValueNullable = __lib.catchArgumentError(() =>
    __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Pointer<Void>),
            Pointer<Void> Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_State_get_value_nullable'));

Pointer<Void> sdkMapviewMapcameraStateToFfiNullable(MapCameraState? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkMapviewMapcameraStateToFfi(value);
  final result = _sdkMapviewMapcameraStateCreateHandleNullable(_handle);
  sdkMapviewMapcameraStateReleaseFfiHandle(_handle);
  return result;
}

MapCameraState? sdkMapviewMapcameraStateFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkMapviewMapcameraStateGetValueNullable(handle);
  final result = sdkMapviewMapcameraStateFromFfi(_handle);
  sdkMapviewMapcameraStateReleaseFfiHandle(_handle);
  return result;
}

void sdkMapviewMapcameraStateReleaseFfiHandleNullable(Pointer<Void> handle) =>
    _sdkMapviewMapcameraStateReleaseHandleNullable(handle);

// End of MapCameraState "private" section.

/// Encapsulates options for flyTo animations.

class MapCameraFlyToOptions {
  /// Duration of animation in milliseconds. Defaults to 1750 milliseconds.
  @Deprecated(
      "Will be removed in v4.12.0. Use [MapCameraFlyToOptions.duration] instead.")
  int durationInMs;

  /// Duration of animation. Defaults to 1750 milliseconds.
  /// If this has non zero value then it has precedence over any settings in [MapCameraFlyToOptions.durationInMs].
  Duration duration;

  /// A bow factor that specifies how high ([MapCameraFlyToOptions.bowFactor] > 0) or low ([MapCameraFlyToOptions.bowFactor] < 0) the camera will fly.
  ///
  /// The highest ([MapCameraFlyToOptions.bowFactor] = 1) or lowest point ([MapCameraFlyToOptions.bowFactor] = -1) of the ballistic animation
  /// curve is relative to the travel distance between current camera target and destination target.
  ///
  /// A bow factor of 0 does not change the camera's [MapCameraState.distanceToTargetInMeters] over time.
  ///
  /// Values greater 0 result in a convex bow animation, values below 0 in a concave bowl animation.
  ///
  /// The bow factor is clamped to \[-1, +1\]. Defaults to 0.5.
  ///
  /// Note that the lowest possible camera distance to earth is 0 meters and that the animation
  /// curve will not go below this value.
  ///
  /// Note that currently, bow factor is ignored and assumed to be 1 if either start or end
  /// of animation has a non zero tilt.
  double bowFactor;

  MapCameraFlyToOptions._(this.durationInMs, this.duration, this.bowFactor);

  factory MapCameraFlyToOptions(int durationInMs, double bowFactor) =>
      $prototype.$init(durationInMs, bowFactor);

  factory MapCameraFlyToOptions.withDefaults() => $prototype.withDefaults();

  factory MapCameraFlyToOptions.withDuration(
          Duration duration, double bowFactor) =>
      $prototype.withDuration(duration, bowFactor);

  /// @nodoc
  @visibleForTesting
  static dynamic $prototype = MapCameraFlyToOptions$Impl();
}

// MapCameraFlyToOptions "private" section, not exported.

final _sdkMapviewMapcameraFlytooptionsCreateHandle = __lib.catchArgumentError(
    () => __lib.nativeLibrary.lookupFunction<
            Pointer<Void> Function(Int32, Uint64, Double),
            Pointer<Void> Function(int, int, double)>(
        'here_sdk_sdk_mapview_MapCamera_FlyToOptions_create_handle'));
final _sdkMapviewMapcameraFlytooptionsReleaseHandle = __lib.catchArgumentError(
    () => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>),
            void Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_FlyToOptions_release_handle'));
final _sdkMapviewMapcameraFlytooptionsGetFielddurationInMs =
    __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
            Int32 Function(Pointer<Void>), int Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_FlyToOptions_get_field_durationInMs'));
final _sdkMapviewMapcameraFlytooptionsGetFieldduration =
    __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
            Uint64 Function(Pointer<Void>), int Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_FlyToOptions_get_field_duration'));
final _sdkMapviewMapcameraFlytooptionsGetFieldbowFactor =
    __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
            Double Function(Pointer<Void>), double Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_FlyToOptions_get_field_bowFactor'));

/// @nodoc
@visibleForTesting
class MapCameraFlyToOptions$Impl {
  MapCameraFlyToOptions $init(int durationInMs, double bowFactor) {
    final _$initFfi = __lib.catchArgumentError(() => __lib.nativeLibrary
        .lookupFunction<Pointer<Void> Function(Int32, Int32, Double),
                Pointer<Void> Function(int, int, double)>(
            'here_sdk_sdk_mapview_MapCamera_FlyToOptions_make__Int_Double'));
    final _durationInMsHandle = (durationInMs);
    final _bowFactorHandle = (bowFactor);
    final __resultHandle = _$initFfi(
        __lib.LibraryContext.isolateId, _durationInMsHandle, _bowFactorHandle);

    try {
      return sdkMapviewMapcameraFlytooptionsFromFfi(__resultHandle);
    } finally {
      sdkMapviewMapcameraFlytooptionsReleaseFfiHandle(__resultHandle);
    }
  }

  MapCameraFlyToOptions withDefaults() {
    final _withDefaultsFfi = __lib.catchArgumentError(() => __lib.nativeLibrary
        .lookupFunction<
            Pointer<Void> Function(Int32),
            Pointer<Void> Function(
                int)>('here_sdk_sdk_mapview_MapCamera_FlyToOptions_make'));
    final __resultHandle = _withDefaultsFfi(__lib.LibraryContext.isolateId);
    try {
      return sdkMapviewMapcameraFlytooptionsFromFfi(__resultHandle);
    } finally {
      sdkMapviewMapcameraFlytooptionsReleaseFfiHandle(__resultHandle);
    }
  }

  MapCameraFlyToOptions withDuration(Duration duration, double bowFactor) {
    final _withDurationFfi = __lib.catchArgumentError(() => __lib.nativeLibrary
        .lookupFunction<Pointer<Void> Function(Int32, Uint64, Double),
                Pointer<Void> Function(int, int, double)>(
            'here_sdk_sdk_mapview_MapCamera_FlyToOptions_make__Duration_Double'));
    final _durationHandle = durationToFfi(duration);
    final _bowFactorHandle = (bowFactor);
    final __resultHandle = _withDurationFfi(
        __lib.LibraryContext.isolateId, _durationHandle, _bowFactorHandle);
    durationReleaseFfiHandle(_durationHandle);

    try {
      return sdkMapviewMapcameraFlytooptionsFromFfi(__resultHandle);
    } finally {
      sdkMapviewMapcameraFlytooptionsReleaseFfiHandle(__resultHandle);
    }
  }
}

Pointer<Void> sdkMapviewMapcameraFlytooptionsToFfi(
    MapCameraFlyToOptions value) {
  final _durationInMsHandle = (value.durationInMs);
  final _durationHandle = durationToFfi(value.duration);
  final _bowFactorHandle = (value.bowFactor);
  final _result = _sdkMapviewMapcameraFlytooptionsCreateHandle(
      _durationInMsHandle, _durationHandle, _bowFactorHandle);

  durationReleaseFfiHandle(_durationHandle);

  return _result;
}

MapCameraFlyToOptions sdkMapviewMapcameraFlytooptionsFromFfi(
    Pointer<Void> handle) {
  final _durationInMsHandle =
      _sdkMapviewMapcameraFlytooptionsGetFielddurationInMs(handle);
  final _durationHandle =
      _sdkMapviewMapcameraFlytooptionsGetFieldduration(handle);
  final _bowFactorHandle =
      _sdkMapviewMapcameraFlytooptionsGetFieldbowFactor(handle);
  try {
    return MapCameraFlyToOptions._((_durationInMsHandle),
        durationFromFfi(_durationHandle), (_bowFactorHandle));
  } finally {
    durationReleaseFfiHandle(_durationHandle);
  }
}

void sdkMapviewMapcameraFlytooptionsReleaseFfiHandle(Pointer<Void> handle) =>
    _sdkMapviewMapcameraFlytooptionsReleaseHandle(handle);

// Nullable MapCameraFlyToOptions

final _sdkMapviewMapcameraFlytooptionsCreateHandleNullable =
    __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
            Pointer<Void> Function(Pointer<Void>),
            Pointer<Void> Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_FlyToOptions_create_handle_nullable'));
final _sdkMapviewMapcameraFlytooptionsReleaseHandleNullable =
    __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
            Void Function(Pointer<Void>), void Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_FlyToOptions_release_handle_nullable'));
final _sdkMapviewMapcameraFlytooptionsGetValueNullable =
    __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
            Pointer<Void> Function(Pointer<Void>),
            Pointer<Void> Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_FlyToOptions_get_value_nullable'));

Pointer<Void> sdkMapviewMapcameraFlytooptionsToFfiNullable(
    MapCameraFlyToOptions? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkMapviewMapcameraFlytooptionsToFfi(value);
  final result = _sdkMapviewMapcameraFlytooptionsCreateHandleNullable(_handle);
  sdkMapviewMapcameraFlytooptionsReleaseFfiHandle(_handle);
  return result;
}

MapCameraFlyToOptions? sdkMapviewMapcameraFlytooptionsFromFfiNullable(
    Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkMapviewMapcameraFlytooptionsGetValueNullable(handle);
  final result = sdkMapviewMapcameraFlytooptionsFromFfi(_handle);
  sdkMapviewMapcameraFlytooptionsReleaseFfiHandle(_handle);
  return result;
}

void sdkMapviewMapcameraFlytooptionsReleaseFfiHandleNullable(
        Pointer<Void> handle) =>
    _sdkMapviewMapcameraFlytooptionsReleaseHandleNullable(handle);

// End of MapCameraFlyToOptions "private" section.

// MapCamera "private" section, not exported.

final _sdkMapviewMapcameraRegisterFinalizer = __lib.catchArgumentError(() =>
    __lib.nativeLibrary.lookupFunction<
        Void Function(Pointer<Void>, Int32, Handle),
        void Function(Pointer<Void>, int,
            Object)>('here_sdk_sdk_mapview_MapCamera_register_finalizer'));
final _sdkMapviewMapcameraCopyHandle = __lib.catchArgumentError(() =>
    __lib.nativeLibrary.lookupFunction<
        Pointer<Void> Function(Pointer<Void>),
        Pointer<Void> Function(
            Pointer<Void>)>('here_sdk_sdk_mapview_MapCamera_copy_handle'));
final _sdkMapviewMapcameraReleaseHandle = __lib.catchArgumentError(() => __lib
    .nativeLibrary
    .lookupFunction<Void Function(Pointer<Void>), void Function(Pointer<Void>)>(
        'here_sdk_sdk_mapview_MapCamera_release_handle'));

class MapCamera$Impl extends __lib.NativeBase implements MapCamera {
  MapCamera$Impl(Pointer<Void> handle) : super(handle);

  @override
  void release() {}

  @override
  void cancelAnimation() {
    final _cancelAnimationFfi = __lib.catchArgumentError(() =>
        __lib.nativeLibrary.lookupFunction<
            Void Function(Pointer<Void>, Int32),
            void Function(Pointer<Void>,
                int)>('here_sdk_sdk_mapview_MapCamera_cancelAnimation'));
    final _handle = this.handle;
    _cancelAnimationFfi(_handle, __lib.LibraryContext.isolateId);
  }

  @override
  void addObserver(MapCameraObserver observer) {
    final _addObserverFfi = __lib.catchArgumentError(() => __lib.nativeLibrary
        .lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>),
                void Function(Pointer<Void>, int, Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_addObserver__MapCameraObserver'));
    final _observerHandle = sdkMapviewMapcameraobserverToFfi(observer);
    final _handle = this.handle;
    _addObserverFfi(_handle, __lib.LibraryContext.isolateId, _observerHandle);
    sdkMapviewMapcameraobserverReleaseFfiHandle(_observerHandle);
  }

  @override
  void removeObserver(MapCameraObserver observer) {
    final _removeObserverFfi = __lib.catchArgumentError(() =>
        __lib.nativeLibrary.lookupFunction<
                Void Function(Pointer<Void>, Int32, Pointer<Void>),
                void Function(Pointer<Void>, int, Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_removeObserver__MapCameraObserver'));
    final _observerHandle = sdkMapviewMapcameraobserverToFfi(observer);
    final _handle = this.handle;
    _removeObserverFfi(
        _handle, __lib.LibraryContext.isolateId, _observerHandle);
    sdkMapviewMapcameraobserverReleaseFfiHandle(_observerHandle);
  }

  @override
  void orbitBy(MapCameraOrientationUpdate delta, Point2D origin) {
    final _orbitByFfi = __lib.catchArgumentError(() => __lib.nativeLibrary
        .lookupFunction<
                Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>),
                void Function(
                    Pointer<Void>, int, Pointer<Void>, Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_orbitBy__OrientationUpdate_Point2D'));
    final _deltaHandle = sdkMapviewMapcameraOrientationupdateToFfi(delta);
    final _originHandle = sdkCorePoint2dToFfi(origin);
    final _handle = this.handle;
    _orbitByFfi(
        _handle, __lib.LibraryContext.isolateId, _deltaHandle, _originHandle);
    sdkMapviewMapcameraOrientationupdateReleaseFfiHandle(_deltaHandle);
    sdkCorePoint2dReleaseFfiHandle(_originHandle);
  }

  @override
  void orbitByWithGeoOrientation(GeoOrientationUpdate delta, Point2D origin) {
    final _orbitByWithGeoOrientationFfi = __lib.catchArgumentError(() =>
        __lib.nativeLibrary.lookupFunction<
                Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>),
                void Function(
                    Pointer<Void>, int, Pointer<Void>, Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_orbitBy__GeoOrientationUpdate_Point2D'));
    final _deltaHandle = sdkCoreGeoorientationupdateToFfi(delta);
    final _originHandle = sdkCorePoint2dToFfi(origin);
    final _handle = this.handle;
    _orbitByWithGeoOrientationFfi(
        _handle, __lib.LibraryContext.isolateId, _deltaHandle, _originHandle);
    sdkCoreGeoorientationupdateReleaseFfiHandle(_deltaHandle);
    sdkCorePoint2dReleaseFfiHandle(_originHandle);
  }

  @override
  void zoomBy(double factor, Point2D origin) {
    final _zoomByFfi = __lib.catchArgumentError(() => __lib.nativeLibrary
        .lookupFunction<
                Void Function(Pointer<Void>, Int32, Double, Pointer<Void>),
                void Function(Pointer<Void>, int, double, Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_zoomBy__Double_Point2D'));
    final _factorHandle = (factor);
    final _originHandle = sdkCorePoint2dToFfi(origin);
    final _handle = this.handle;
    _zoomByFfi(
        _handle, __lib.LibraryContext.isolateId, _factorHandle, _originHandle);

    sdkCorePoint2dReleaseFfiHandle(_originHandle);
  }

  @override
  void zoomTo(double zoomLevel) {
    final _zoomToFfi = __lib.catchArgumentError(() => __lib.nativeLibrary
        .lookupFunction<
            Void Function(Pointer<Void>, Int32, Double),
            void Function(Pointer<Void>, int,
                double)>('here_sdk_sdk_mapview_MapCamera_zoomTo__Double'));
    final _zoomLevelHandle = (zoomLevel);
    final _handle = this.handle;
    _zoomToFfi(_handle, __lib.LibraryContext.isolateId, _zoomLevelHandle);
  }

  @override
  void applyUpdate(MapCameraUpdate cameraUpdate) {
    final _applyUpdateFfi = __lib.catchArgumentError(() => __lib.nativeLibrary
        .lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>),
                void Function(Pointer<Void>, int, Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_applyUpdate__MapCameraUpdate'));
    final _cameraUpdateHandle = sdkMapviewMapcameraupdateToFfi(cameraUpdate);
    final _handle = this.handle;
    _applyUpdateFfi(
        _handle, __lib.LibraryContext.isolateId, _cameraUpdateHandle);
    sdkMapviewMapcameraupdateReleaseFfiHandle(_cameraUpdateHandle);
  }

  @override
  void startAnimation(MapCameraAnimation cameraAnimation) {
    final _startAnimationFfi = __lib.catchArgumentError(() =>
        __lib.nativeLibrary.lookupFunction<
                Void Function(Pointer<Void>, Int32, Pointer<Void>),
                void Function(Pointer<Void>, int, Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_startAnimation__MapCameraAnimation'));
    final _cameraAnimationHandle =
        sdkMapviewMapcameraanimationToFfi(cameraAnimation);
    final _handle = this.handle;
    _startAnimationFfi(
        _handle, __lib.LibraryContext.isolateId, _cameraAnimationHandle);
    sdkMapviewMapcameraanimationReleaseFfiHandle(_cameraAnimationHandle);
  }

  @override
  void lookAtPoint(GeoCoordinates target) {
    final _lookAtPointFfi = __lib.catchArgumentError(() => __lib.nativeLibrary
        .lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>),
                void Function(Pointer<Void>, int, Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_lookAt__GeoCoordinates'));
    final _targetHandle = sdkCoreGeocoordinatesToFfi(target);
    final _handle = this.handle;
    _lookAtPointFfi(_handle, __lib.LibraryContext.isolateId, _targetHandle);
    sdkCoreGeocoordinatesReleaseFfiHandle(_targetHandle);
  }

  @override
  void lookAtPointWithDistance(GeoCoordinates target, double distanceInMeters) {
    final _lookAtPointWithDistanceFfi = __lib.catchArgumentError(() =>
        __lib.nativeLibrary.lookupFunction<
                Void Function(Pointer<Void>, Int32, Pointer<Void>, Double),
                void Function(Pointer<Void>, int, Pointer<Void>, double)>(
            'here_sdk_sdk_mapview_MapCamera_lookAt__GeoCoordinates_Double'));
    final _targetHandle = sdkCoreGeocoordinatesToFfi(target);
    final _distanceInMetersHandle = (distanceInMeters);
    final _handle = this.handle;
    _lookAtPointWithDistanceFfi(_handle, __lib.LibraryContext.isolateId,
        _targetHandle, _distanceInMetersHandle);
    sdkCoreGeocoordinatesReleaseFfiHandle(_targetHandle);
  }

  @override
  void lookAtPointWithOrientationAndDistance(GeoCoordinates target,
      MapCameraOrientationUpdate orientation, double distanceInMeters) {
    final _lookAtPointWithOrientationAndDistanceFfi = __lib.catchArgumentError(
        () => __lib.nativeLibrary.lookupFunction<
                Void Function(
                    Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>, Double),
                void Function(
                    Pointer<Void>, int, Pointer<Void>, Pointer<Void>, double)>(
            'here_sdk_sdk_mapview_MapCamera_lookAt__GeoCoordinates_OrientationUpdate_Double'));
    final _targetHandle = sdkCoreGeocoordinatesToFfi(target);
    final _orientationHandle =
        sdkMapviewMapcameraOrientationupdateToFfi(orientation);
    final _distanceInMetersHandle = (distanceInMeters);
    final _handle = this.handle;
    _lookAtPointWithOrientationAndDistanceFfi(
        _handle,
        __lib.LibraryContext.isolateId,
        _targetHandle,
        _orientationHandle,
        _distanceInMetersHandle);
    sdkCoreGeocoordinatesReleaseFfiHandle(_targetHandle);
    sdkMapviewMapcameraOrientationupdateReleaseFfiHandle(_orientationHandle);
  }

  @override
  void lookAtPointWithGeoOrientationAndDistance(GeoCoordinates target,
      GeoOrientationUpdate orientation, double distanceInMeters) {
    final _lookAtPointWithGeoOrientationAndDistanceFfi =
        __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
                Void Function(
                    Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>, Double),
                void Function(
                    Pointer<Void>, int, Pointer<Void>, Pointer<Void>, double)>(
            'here_sdk_sdk_mapview_MapCamera_lookAt__GeoCoordinates_GeoOrientationUpdate_Double'));
    final _targetHandle = sdkCoreGeocoordinatesToFfi(target);
    final _orientationHandle = sdkCoreGeoorientationupdateToFfi(orientation);
    final _distanceInMetersHandle = (distanceInMeters);
    final _handle = this.handle;
    _lookAtPointWithGeoOrientationAndDistanceFfi(
        _handle,
        __lib.LibraryContext.isolateId,
        _targetHandle,
        _orientationHandle,
        _distanceInMetersHandle);
    sdkCoreGeocoordinatesReleaseFfiHandle(_targetHandle);
    sdkCoreGeoorientationupdateReleaseFfiHandle(_orientationHandle);
  }

  @override
  void lookAtAreaWithOrientation(
      GeoBox target, MapCameraOrientationUpdate orientation) {
    final _lookAtAreaWithOrientationFfi = __lib.catchArgumentError(() =>
        __lib.nativeLibrary.lookupFunction<
                Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>),
                void Function(
                    Pointer<Void>, int, Pointer<Void>, Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_lookAt__GeoBox_OrientationUpdate'));
    final _targetHandle = sdkCoreGeoboxToFfi(target);
    final _orientationHandle =
        sdkMapviewMapcameraOrientationupdateToFfi(orientation);
    final _handle = this.handle;
    _lookAtAreaWithOrientationFfi(_handle, __lib.LibraryContext.isolateId,
        _targetHandle, _orientationHandle);
    sdkCoreGeoboxReleaseFfiHandle(_targetHandle);
    sdkMapviewMapcameraOrientationupdateReleaseFfiHandle(_orientationHandle);
  }

  @override
  void lookAtAreaWithGeoOrientation(
      GeoBox target, GeoOrientationUpdate orientation) {
    final _lookAtAreaWithGeoOrientationFfi = __lib.catchArgumentError(() =>
        __lib.nativeLibrary.lookupFunction<
                Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>),
                void Function(
                    Pointer<Void>, int, Pointer<Void>, Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_lookAt__GeoBox_GeoOrientationUpdate'));
    final _targetHandle = sdkCoreGeoboxToFfi(target);
    final _orientationHandle = sdkCoreGeoorientationupdateToFfi(orientation);
    final _handle = this.handle;
    _lookAtAreaWithGeoOrientationFfi(_handle, __lib.LibraryContext.isolateId,
        _targetHandle, _orientationHandle);
    sdkCoreGeoboxReleaseFfiHandle(_targetHandle);
    sdkCoreGeoorientationupdateReleaseFfiHandle(_orientationHandle);
  }

  @override
  void setDistanceToTarget(double distanceInMeters) {
    final _setDistanceToTargetFfi = __lib.catchArgumentError(() =>
        __lib.nativeLibrary.lookupFunction<
                Void Function(Pointer<Void>, Int32, Double),
                void Function(Pointer<Void>, int, double)>(
            'here_sdk_sdk_mapview_MapCamera_setDistanceToTarget__Double'));
    final _distanceInMetersHandle = (distanceInMeters);
    final _handle = this.handle;
    _setDistanceToTargetFfi(
        _handle, __lib.LibraryContext.isolateId, _distanceInMetersHandle);
  }

  @override
  void setTargetOrientation(MapCameraOrientationUpdate orientation) {
    final _setTargetOrientationFfi = __lib.catchArgumentError(() =>
        __lib.nativeLibrary.lookupFunction<
                Void Function(Pointer<Void>, Int32, Pointer<Void>),
                void Function(Pointer<Void>, int, Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_setTargetOrientation__OrientationUpdate'));
    final _orientationHandle =
        sdkMapviewMapcameraOrientationupdateToFfi(orientation);
    final _handle = this.handle;
    _setTargetOrientationFfi(
        _handle, __lib.LibraryContext.isolateId, _orientationHandle);
    sdkMapviewMapcameraOrientationupdateReleaseFfiHandle(_orientationHandle);
  }

  @override
  void setOrientationAtTarget(GeoOrientationUpdate orientation) {
    final _setOrientationAtTargetFfi = __lib.catchArgumentError(() =>
        __lib.nativeLibrary.lookupFunction<
                Void Function(Pointer<Void>, Int32, Pointer<Void>),
                void Function(Pointer<Void>, int, Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_setOrientationAtTarget__GeoOrientationUpdate'));
    final _orientationHandle = sdkCoreGeoorientationupdateToFfi(orientation);
    final _handle = this.handle;
    _setOrientationAtTargetFfi(
        _handle, __lib.LibraryContext.isolateId, _orientationHandle);
    sdkCoreGeoorientationupdateReleaseFfiHandle(_orientationHandle);
  }

  @override
  void flyTo(GeoCoordinates target) {
    final _flyToFfi = __lib.catchArgumentError(() => __lib.nativeLibrary
        .lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>),
                void Function(Pointer<Void>, int, Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_flyTo__GeoCoordinates'));
    final _targetHandle = sdkCoreGeocoordinatesToFfi(target);
    final _handle = this.handle;
    _flyToFfi(_handle, __lib.LibraryContext.isolateId, _targetHandle);
    sdkCoreGeocoordinatesReleaseFfiHandle(_targetHandle);
  }

  @override
  void flyToWithOptions(
      GeoCoordinates target, MapCameraFlyToOptions animationOptions) {
    final _flyToWithOptionsFfi = __lib.catchArgumentError(() =>
        __lib.nativeLibrary.lookupFunction<
                Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>),
                void Function(
                    Pointer<Void>, int, Pointer<Void>, Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_flyTo__GeoCoordinates_FlyToOptions'));
    final _targetHandle = sdkCoreGeocoordinatesToFfi(target);
    final _animationOptionsHandle =
        sdkMapviewMapcameraFlytooptionsToFfi(animationOptions);
    final _handle = this.handle;
    _flyToWithOptionsFfi(_handle, __lib.LibraryContext.isolateId, _targetHandle,
        _animationOptionsHandle);
    sdkCoreGeocoordinatesReleaseFfiHandle(_targetHandle);
    sdkMapviewMapcameraFlytooptionsReleaseFfiHandle(_animationOptionsHandle);
  }

  @override
  void flyToWithOptionsAndDistance(GeoCoordinates target,
      double distanceInMeters, MapCameraFlyToOptions animationOptions) {
    final _flyToWithOptionsAndDistanceFfi = __lib.catchArgumentError(() =>
        __lib.nativeLibrary.lookupFunction<
                Void Function(
                    Pointer<Void>, Int32, Pointer<Void>, Double, Pointer<Void>),
                void Function(
                    Pointer<Void>, int, Pointer<Void>, double, Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_flyTo__GeoCoordinates_Double_FlyToOptions'));
    final _targetHandle = sdkCoreGeocoordinatesToFfi(target);
    final _distanceInMetersHandle = (distanceInMeters);
    final _animationOptionsHandle =
        sdkMapviewMapcameraFlytooptionsToFfi(animationOptions);
    final _handle = this.handle;
    _flyToWithOptionsAndDistanceFfi(_handle, __lib.LibraryContext.isolateId,
        _targetHandle, _distanceInMetersHandle, _animationOptionsHandle);
    sdkCoreGeocoordinatesReleaseFfiHandle(_targetHandle);

    sdkMapviewMapcameraFlytooptionsReleaseFfiHandle(_animationOptionsHandle);
  }

  @override
  void flyToWithOptionsAndOrientation(
      GeoCoordinates target,
      MapCameraOrientationUpdate orientation,
      MapCameraFlyToOptions animationOptions) {
    final _flyToWithOptionsAndOrientationFfi = __lib.catchArgumentError(() =>
        __lib.nativeLibrary.lookupFunction<
                Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>,
                    Pointer<Void>),
                void Function(Pointer<Void>, int, Pointer<Void>, Pointer<Void>,
                    Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_flyTo__GeoCoordinates_OrientationUpdate_FlyToOptions'));
    final _targetHandle = sdkCoreGeocoordinatesToFfi(target);
    final _orientationHandle =
        sdkMapviewMapcameraOrientationupdateToFfi(orientation);
    final _animationOptionsHandle =
        sdkMapviewMapcameraFlytooptionsToFfi(animationOptions);
    final _handle = this.handle;
    _flyToWithOptionsAndOrientationFfi(_handle, __lib.LibraryContext.isolateId,
        _targetHandle, _orientationHandle, _animationOptionsHandle);
    sdkCoreGeocoordinatesReleaseFfiHandle(_targetHandle);
    sdkMapviewMapcameraOrientationupdateReleaseFfiHandle(_orientationHandle);
    sdkMapviewMapcameraFlytooptionsReleaseFfiHandle(_animationOptionsHandle);
  }

  @override
  void flyToWithOptionsAndGeoOrientation(
      GeoCoordinates target,
      GeoOrientationUpdate orientation,
      MapCameraFlyToOptions animationOptions) {
    final _flyToWithOptionsAndGeoOrientationFfi = __lib.catchArgumentError(() =>
        __lib.nativeLibrary.lookupFunction<
                Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>,
                    Pointer<Void>),
                void Function(Pointer<Void>, int, Pointer<Void>, Pointer<Void>,
                    Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_flyTo__GeoCoordinates_GeoOrientationUpdate_FlyToOptions'));
    final _targetHandle = sdkCoreGeocoordinatesToFfi(target);
    final _orientationHandle = sdkCoreGeoorientationupdateToFfi(orientation);
    final _animationOptionsHandle =
        sdkMapviewMapcameraFlytooptionsToFfi(animationOptions);
    final _handle = this.handle;
    _flyToWithOptionsAndGeoOrientationFfi(
        _handle,
        __lib.LibraryContext.isolateId,
        _targetHandle,
        _orientationHandle,
        _animationOptionsHandle);
    sdkCoreGeocoordinatesReleaseFfiHandle(_targetHandle);
    sdkCoreGeoorientationupdateReleaseFfiHandle(_orientationHandle);
    sdkMapviewMapcameraFlytooptionsReleaseFfiHandle(_animationOptionsHandle);
  }

  @override
  void flyToWithOptionsAndOrientationAndDistance(
      GeoCoordinates target,
      MapCameraOrientationUpdate orientation,
      double distanceInMeters,
      MapCameraFlyToOptions animationOptions) {
    final _flyToWithOptionsAndOrientationAndDistanceFfi =
        __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
                Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>,
                    Double, Pointer<Void>),
                void Function(Pointer<Void>, int, Pointer<Void>, Pointer<Void>,
                    double, Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_flyTo__GeoCoordinates_OrientationUpdate_Double_FlyToOptions'));
    final _targetHandle = sdkCoreGeocoordinatesToFfi(target);
    final _orientationHandle =
        sdkMapviewMapcameraOrientationupdateToFfi(orientation);
    final _distanceInMetersHandle = (distanceInMeters);
    final _animationOptionsHandle =
        sdkMapviewMapcameraFlytooptionsToFfi(animationOptions);
    final _handle = this.handle;
    _flyToWithOptionsAndOrientationAndDistanceFfi(
        _handle,
        __lib.LibraryContext.isolateId,
        _targetHandle,
        _orientationHandle,
        _distanceInMetersHandle,
        _animationOptionsHandle);
    sdkCoreGeocoordinatesReleaseFfiHandle(_targetHandle);
    sdkMapviewMapcameraOrientationupdateReleaseFfiHandle(_orientationHandle);

    sdkMapviewMapcameraFlytooptionsReleaseFfiHandle(_animationOptionsHandle);
  }

  @override
  void flyToWithOptionsAndGeoOrientationAndDistance(
      GeoCoordinates target,
      GeoOrientationUpdate orientation,
      double distanceInMeters,
      MapCameraFlyToOptions animationOptions) {
    final _flyToWithOptionsAndGeoOrientationAndDistanceFfi =
        __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
                Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>,
                    Double, Pointer<Void>),
                void Function(Pointer<Void>, int, Pointer<Void>, Pointer<Void>,
                    double, Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_flyTo__GeoCoordinates_GeoOrientationUpdate_Double_FlyToOptions'));
    final _targetHandle = sdkCoreGeocoordinatesToFfi(target);
    final _orientationHandle = sdkCoreGeoorientationupdateToFfi(orientation);
    final _distanceInMetersHandle = (distanceInMeters);
    final _animationOptionsHandle =
        sdkMapviewMapcameraFlytooptionsToFfi(animationOptions);
    final _handle = this.handle;
    _flyToWithOptionsAndGeoOrientationAndDistanceFfi(
        _handle,
        __lib.LibraryContext.isolateId,
        _targetHandle,
        _orientationHandle,
        _distanceInMetersHandle,
        _animationOptionsHandle);
    sdkCoreGeocoordinatesReleaseFfiHandle(_targetHandle);
    sdkCoreGeoorientationupdateReleaseFfiHandle(_orientationHandle);

    sdkMapviewMapcameraFlytooptionsReleaseFfiHandle(_animationOptionsHandle);
  }

  @override
  void lookAtAreaWithOrientationAndViewRectangle(GeoBox target,
      MapCameraOrientationUpdate orientation, Rectangle2D viewRectangle) {
    final _lookAtAreaWithOrientationAndViewRectangleFfi =
        __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
                Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>,
                    Pointer<Void>),
                void Function(Pointer<Void>, int, Pointer<Void>, Pointer<Void>,
                    Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_lookAt__GeoBox_OrientationUpdate_Rectangle2D'));
    final _targetHandle = sdkCoreGeoboxToFfi(target);
    final _orientationHandle =
        sdkMapviewMapcameraOrientationupdateToFfi(orientation);
    final _viewRectangleHandle = sdkCoreRectangle2dToFfi(viewRectangle);
    final _handle = this.handle;
    _lookAtAreaWithOrientationAndViewRectangleFfi(
        _handle,
        __lib.LibraryContext.isolateId,
        _targetHandle,
        _orientationHandle,
        _viewRectangleHandle);
    sdkCoreGeoboxReleaseFfiHandle(_targetHandle);
    sdkMapviewMapcameraOrientationupdateReleaseFfiHandle(_orientationHandle);
    sdkCoreRectangle2dReleaseFfiHandle(_viewRectangleHandle);
  }

  @override
  void lookAtAreaWithGeoOrientationAndViewRectangle(GeoBox target,
      GeoOrientationUpdate orientation, Rectangle2D viewRectangle) {
    final _lookAtAreaWithGeoOrientationAndViewRectangleFfi =
        __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
                Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>,
                    Pointer<Void>),
                void Function(Pointer<Void>, int, Pointer<Void>, Pointer<Void>,
                    Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_lookAt__GeoBox_GeoOrientationUpdate_Rectangle2D'));
    final _targetHandle = sdkCoreGeoboxToFfi(target);
    final _orientationHandle = sdkCoreGeoorientationupdateToFfi(orientation);
    final _viewRectangleHandle = sdkCoreRectangle2dToFfi(viewRectangle);
    final _handle = this.handle;
    _lookAtAreaWithGeoOrientationAndViewRectangleFfi(
        _handle,
        __lib.LibraryContext.isolateId,
        _targetHandle,
        _orientationHandle,
        _viewRectangleHandle);
    sdkCoreGeoboxReleaseFfiHandle(_targetHandle);
    sdkCoreGeoorientationupdateReleaseFfiHandle(_orientationHandle);
    sdkCoreRectangle2dReleaseFfiHandle(_viewRectangleHandle);
  }

  @override
  void animateToAreaWithOrientationAndViewRectangle(
      GeoBox target,
      MapCameraOrientationUpdate orientation,
      Rectangle2D viewRectangle,
      int durationInMs) {
    final _animateToAreaWithOrientationAndViewRectangleFfi =
        __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
                Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>,
                    Pointer<Void>, Int32),
                void Function(Pointer<Void>, int, Pointer<Void>, Pointer<Void>,
                    Pointer<Void>, int)>(
            'here_sdk_sdk_mapview_MapCamera_animateTo__GeoBox_OrientationUpdate_Rectangle2D_Int'));
    final _targetHandle = sdkCoreGeoboxToFfi(target);
    final _orientationHandle =
        sdkMapviewMapcameraOrientationupdateToFfi(orientation);
    final _viewRectangleHandle = sdkCoreRectangle2dToFfi(viewRectangle);
    final _durationInMsHandle = (durationInMs);
    final _handle = this.handle;
    _animateToAreaWithOrientationAndViewRectangleFfi(
        _handle,
        __lib.LibraryContext.isolateId,
        _targetHandle,
        _orientationHandle,
        _viewRectangleHandle,
        _durationInMsHandle);
    sdkCoreGeoboxReleaseFfiHandle(_targetHandle);
    sdkMapviewMapcameraOrientationupdateReleaseFfiHandle(_orientationHandle);
    sdkCoreRectangle2dReleaseFfiHandle(_viewRectangleHandle);
  }

  @override
  void animateToAreaWithGeoOrientationAndViewRectangle(
      GeoBox target,
      GeoOrientationUpdate orientation,
      Rectangle2D viewRectangle,
      int durationInMs) {
    final _animateToAreaWithGeoOrientationAndViewRectangleFfi =
        __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
                Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>,
                    Pointer<Void>, Int32),
                void Function(Pointer<Void>, int, Pointer<Void>, Pointer<Void>,
                    Pointer<Void>, int)>(
            'here_sdk_sdk_mapview_MapCamera_animateTo__GeoBox_GeoOrientationUpdate_Rectangle2D_Int'));
    final _targetHandle = sdkCoreGeoboxToFfi(target);
    final _orientationHandle = sdkCoreGeoorientationupdateToFfi(orientation);
    final _viewRectangleHandle = sdkCoreRectangle2dToFfi(viewRectangle);
    final _durationInMsHandle = (durationInMs);
    final _handle = this.handle;
    _animateToAreaWithGeoOrientationAndViewRectangleFfi(
        _handle,
        __lib.LibraryContext.isolateId,
        _targetHandle,
        _orientationHandle,
        _viewRectangleHandle,
        _durationInMsHandle);
    sdkCoreGeoboxReleaseFfiHandle(_targetHandle);
    sdkCoreGeoorientationupdateReleaseFfiHandle(_orientationHandle);
    sdkCoreRectangle2dReleaseFfiHandle(_viewRectangleHandle);
  }

  @override
  MapCameraState get state {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary
        .lookupFunction<
            Pointer<Void> Function(Pointer<Void>, Int32),
            Pointer<Void> Function(Pointer<Void>,
                int)>('here_sdk_sdk_mapview_MapCamera_state_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return sdkMapviewMapcameraStateFromFfi(__resultHandle);
    } finally {
      sdkMapviewMapcameraStateReleaseFfiHandle(__resultHandle);
    }
  }

  @override
  GeoBox? get boundingBox {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary
        .lookupFunction<
            Pointer<Void> Function(Pointer<Void>, Int32),
            Pointer<Void> Function(Pointer<Void>,
                int)>('here_sdk_sdk_mapview_MapCamera_boundingBox_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return sdkCoreGeoboxFromFfiNullable(__resultHandle);
    } finally {
      sdkCoreGeoboxReleaseFfiHandleNullable(__resultHandle);
    }
  }

  @override
  MapCameraLimits get limits {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary
        .lookupFunction<
            Pointer<Void> Function(Pointer<Void>, Int32),
            Pointer<Void> Function(Pointer<Void>,
                int)>('here_sdk_sdk_mapview_MapCamera_limits_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return sdkMapviewMapcameralimitsFromFfi(__resultHandle);
    } finally {
      sdkMapviewMapcameralimitsReleaseFfiHandle(__resultHandle);
    }
  }

  @override
  Point2D get principalPoint {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary
        .lookupFunction<
            Pointer<Void> Function(Pointer<Void>, Int32),
            Pointer<Void> Function(Pointer<Void>,
                int)>('here_sdk_sdk_mapview_MapCamera_principalPoint_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return sdkCorePoint2dFromFfi(__resultHandle);
    } finally {
      sdkCorePoint2dReleaseFfiHandle(__resultHandle);
    }
  }

  @override
  set principalPoint(Point2D value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary
        .lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>),
                void Function(Pointer<Void>, int, Pointer<Void>)>(
            'here_sdk_sdk_mapview_MapCamera_principalPoint_set__Point2D'));
    final _valueHandle = sdkCorePoint2dToFfi(value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);
    sdkCorePoint2dReleaseFfiHandle(_valueHandle);
  }
}

Pointer<Void> sdkMapviewMapcameraToFfi(MapCamera value) =>
    _sdkMapviewMapcameraCopyHandle((value as __lib.NativeBase).handle);

MapCamera sdkMapviewMapcameraFromFfi(Pointer<Void> handle) {
  final instance = __lib.getCachedInstance(handle);
  if (instance != null && instance is MapCamera) return instance;

  final _copiedHandle = _sdkMapviewMapcameraCopyHandle(handle);
  final result = MapCamera$Impl(_copiedHandle);
  __lib.cacheInstance(_copiedHandle, result);
  _sdkMapviewMapcameraRegisterFinalizer(
      _copiedHandle, __lib.LibraryContext.isolateId, result);
  return result;
}

void sdkMapviewMapcameraReleaseFfiHandle(Pointer<Void> handle) =>
    _sdkMapviewMapcameraReleaseHandle(handle);

Pointer<Void> sdkMapviewMapcameraToFfiNullable(MapCamera? value) =>
    value != null
        ? sdkMapviewMapcameraToFfi(value)
        : Pointer<Void>.fromAddress(0);

MapCamera? sdkMapviewMapcameraFromFfiNullable(Pointer<Void> handle) =>
    handle.address != 0 ? sdkMapviewMapcameraFromFfi(handle) : null;

void sdkMapviewMapcameraReleaseFfiHandleNullable(Pointer<Void> handle) =>
    _sdkMapviewMapcameraReleaseHandle(handle);

// End of MapCamera "private" section.

