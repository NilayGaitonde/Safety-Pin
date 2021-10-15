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
import 'package:flutter/widgets.dart';
import 'package:here_sdk/core.dart';

/// This class can be used to display [Widget] at a fixed geographical location on the map
class WidgetPin {
  /// Creates a [WidgetPin] displaying child [Widget] at coordinates location on the map
  /// Don't use this constructor directly. Instead use [HereMapController.pinWidget] to create a [WidgetPin].
  WidgetPin({required this.child, required GeoCoordinates coordinates, Anchor2D? anchor, this.onChange, this.onUnpin}) {
    // _coordinates is private and thus must be initialised differently to child, which is public and final
    // and thus read only
    _coordinates = coordinates;

    // Only assign the user's anchor if one was actually passed in, so that we have a valid default one with
    // which to work
    if (anchor != null) {
      _anchor = anchor;
    }
  }

  final Widget child;
  late GeoCoordinates _coordinates;
  Anchor2D _anchor = Anchor2D();
  final GlobalKey _key = GlobalKey();
  final Function()? onChange;
  final Function(WidgetPin)? onUnpin;

  // position on screen, will be changing as map is panned
  Point2D _point = Point2D(0.0, 0.0);

  GeoCoordinates get coordinates => _coordinates;

  /// Changes geographical location of the [WidgetPin]
  set coordinates(GeoCoordinates newCoords) {
    _coordinates = newCoords;
    onChange?.call();
  }

  Anchor2D get anchor => _anchor;

  /// Changes anchor point of the pin
  set anchor(Anchor2D newAnchor) {
    _anchor = newAnchor;
    onChange?.call();
  }

  /// Removes this [WidgetPin] from the map
  unpin() => onUnpin?.call(this);

  /// Creates a widget for this [WidgetPin]
  Widget makeWidget(BuildContext context) {
    final Size size = _getWidgetSize();
    final double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final Point2D pos = _getXY(size, pixelRatio);
    Widget widget = Positioned(
      key: _key,
      left: pos.x,
      top: pos.y,
      child: SizeChangedLayoutNotifier(child: child),
    );

    if (size.width == 0 || size.height == 0) {
      // Size of widget is not known until first render.
      // Without size we can't calculate position taking anchor into account
      //  so in first run we render the widget offstage just to get the size.
      // Also some widgets (e.g. Image.network()) may need some time until the size is known
      //  we rely on SizeChangedLayoutNotifier to let us know when their size changed so we can re-render
      return Offstage(child: Stack(children: <Widget>[widget]));
    }
    // real render when we have the size
    return widget;
  }

  updateScreenPosition(Point2D screenPosition) {
    _point = screenPosition;
  }

  // Calculate screen position of the pin taking anchor into account
  Point2D _getXY(Size size, double pixelRatio) {
    return Point2D(
      _point.x / pixelRatio - size.width * anchor.horizontal,
      _point.y / pixelRatio - size.height * anchor.vertical,
    );
  }

  // This will return a size of 0 x 0 if the widget was not rendered yet
  Size _getWidgetSize() {
    final RenderBox? renderBoxRed = _key.currentContext?.findRenderObject() as RenderBox?;
    return renderBoxRed?.size ?? Size.zero;
  }
}
