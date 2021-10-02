import 'package:flutter/material.dart';
import 'package:safety_pin/pages/home.dart';

class SeniorCitizen extends StatelessWidget {
  const SeniorCitizen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('SENIOR CITIZEN'),
      ),
      body: GMap(),
    );
  }
}
