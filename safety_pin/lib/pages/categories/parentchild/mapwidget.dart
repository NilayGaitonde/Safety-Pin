import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';

class MapWidget extends StatelessWidget {
  final String latitude;
  final String longitude;
  final String location;

  const MapWidget({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$location"),
        centerTitle: true,
      ),
      body: HereMap(onMapCreated: _onMapCreated),
    );
  }

  Future<void> _onMapCreated(HereMapController hereMapController) async {
    print('Here maps widget creating');
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('${position.latitude.toString()}\n${position.longitude.toString()}');
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.satellite,
        (MapError? error) {
      if (error != null) {
        print('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }

      const double distanceToEarthInMeters = 1000;
      hereMapController.camera.lookAtPointWithDistance(
          GeoCoordinates(
              position.latitude.toDouble(), position.longitude.toDouble()),
          distanceToEarthInMeters);
    });
  }
}
