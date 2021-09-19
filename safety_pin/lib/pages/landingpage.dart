import 'package:flutter/material.dart';

// device id=520010bd59a5552f
import 'package:avatar_glow/avatar_glow.dart';
import 'package:telephony/telephony.dart';
import 'package:geolocator/geolocator.dart';

class LandingPage extends StatelessWidget {
  // LandingPage({Key? key}) : super(key: key);
  // late UserSimplePreferences _preferences;
  final Telephony telephony = Telephony.instance;
  final numbers = ['9987207322', '9004398994', '9867726478'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.redAccent[400],
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40.0, 0, 0),
                  child: Text('EMERGENCY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        //   fontWeight: FontWeight.bold,
                      )),
                ),
                //   SizedBox(height: 40.0),
                Container(
                  height: 460.0,
                  width: 460.0,
                  child: FittedBox(
                    child: AvatarGlow(
                      endRadius: 60.0,
                      child: FloatingActionButton(
                        onPressed: () async {
                          print('Sending sms');
                          Position position =
                              await Geolocator.getCurrentPosition(
                                  desiredAccuracy: LocationAccuracy.high);
                          telephony.sendSms(
                              to:
                                  "(650) 555-1212;9987207322;9029924188;9987207322",
                              message:
                                  "Hello! I am feeling unsafe and have messaged you\nThis is my current location https://www.google.com/maps/search/?api=1&query=${position.latitude.toString()},${position.longitude.toString()} ($position).\nHere is what you can do to help:\n1) Call the police @ 100\n2)Try to reach the co-ordinates. You yourself can reach there or ask a friend to reach there as early as possible\n3)Video Call or even a normal call will help as this can often disarm the attacker\n",
                              isMultipart: true);
                        },
                        child: Text(
                          'HELP!',
                          style: TextStyle(color: Colors.red[400]),
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
