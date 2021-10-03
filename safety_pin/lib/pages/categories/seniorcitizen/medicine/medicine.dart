import 'package:flutter/material.dart';
import 'package:safety_pin/helpers/dialogHelper.dart';

class Medicine extends StatefulWidget {
  const Medicine({Key? key}) : super(key: key);

  @override
  _MedicineState createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your medicines"),
      ),
      body: Column(
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          DialogHelper.addmedicine(context);
        },
      ),
    );
  }
}
