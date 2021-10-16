import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';

class HereMaps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HERE SDK for Flutter - Hello Map!',
      home: HereMap(onMapCreated: _onMapCreated),
    );
  }

  Future<void> _onMapCreated(HereMapController hereMapController) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('${position.latitude.toString()}\n${position.longitude.toString()}');
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.satellite,
        (MapError? error) {
      if (error != null) {
        print('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }

      const double distanceToEarthInMeters = 100;
      hereMapController.camera.lookAtPointWithDistance(
          GeoCoordinates(
              position.latitude.toDouble(), position.longitude.toDouble()),
          distanceToEarthInMeters);
    });
  }
}
