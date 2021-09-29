import 'package:flutter/material.dart';

// device id=520010bd59a5552f
import 'package:avatar_glow/avatar_glow.dart';
import 'package:safety_pin/services/store.dart';
import 'package:telephony/telephony.dart';

class LandingPage extends StatelessWidget {
  final Telephony telephony = Telephony.instance;
  final List? numbers = UserSimplePreferences.getContacts();
  final String? message = UserSimplePreferences.getMessage();

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
                          print(numbers);
                          print(message);
                          numbers?.forEach((recepient) async {
                            print(recepient);
                            await telephony.sendSms(
                                to: recepient,
                                message: message as String,
                                isMultipart: true);
                          });
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
