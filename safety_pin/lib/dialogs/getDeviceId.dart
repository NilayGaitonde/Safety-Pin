import 'package:flutter/material.dart';
import 'package:safety_pin/helpers/dialogHelper.dart';
import 'package:safety_pin/services/store.dart';

class GetDeviceID extends StatefulWidget {
  const GetDeviceID({Key? key}) : super(key: key);

  @override
  State<GetDeviceID> createState() => _GetDeviceIDState();
}

class _GetDeviceIDState extends State<GetDeviceID> {
  final TextEditingController _deviceID = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) {
    print('Asking for device info');
    return Container(
      height: 370,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                'Enter device ID:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 10),
              Container(
                width: 270,
                child: TextField(
                  controller: _deviceID,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                UserSimplePreferences.saveDeviceID(_deviceID.text);
                Navigator.pop(context);
              },
              child: Text('Done')),
          ElevatedButton(
              onPressed: () {
                DialogHelper.showHelp(context);
              },
              child: Text('IDK what I am doing'))
        ],
      ),
    );
  }
}
