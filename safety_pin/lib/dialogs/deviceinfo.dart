import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safety_pin/helpers/firebaseHelper.dart';

class DeviceInfo extends StatelessWidget {
  const DeviceInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) {
    print('Getting device info');
    return Container(
      height: 200,
      width: 100,
      decoration: BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 50,
            ),
            Text('Device ID:${Device.deviceId}'),
            ElevatedButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: Device.deviceId));
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                backgroundColor: Colors.pink,
                primary: Colors.white,
              ),
              child: Text('Copy the device id'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                backgroundColor: Colors.pink,
                primary: Colors.white,
              ),
              child: Text('Got it!'),
            ),
          ],
        ),
      ),
    );
  }
}
