import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:safety_pin/helpers/dialogHelper.dart';
import 'package:safety_pin/helpers/firebaseHelper.dart';
import 'package:safety_pin/pages/Welcome.dart';
import 'package:safety_pin/pages/categories/seniorcitizen/medicine/medicine.dart';
import 'package:safety_pin/pages/home.dart';
import 'package:safety_pin/pages/profilepage.dart';
import 'package:safety_pin/services/store.dart';

class Parent extends StatefulWidget {
  const Parent({Key? key}) : super(key: key);

  @override
  _ParentState createState() => _ParentState();
}

class _ParentState extends State<Parent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Align(
            alignment: Alignment(-0.3, 0.0),
            child: Text('PARENT', style: TextStyle(color: Colors.white))),
      ),
      body: HereMaps(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 120.0,
              child: DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Hello,',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Center(
                      child: Text(
                        '${UserSimplePreferences.getName()}',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(color: Colors.pink),
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(10),
              child: ListTile(
                trailing: Icon(
                  Icons.contacts,
                  color: Colors.pink,
                  size: 30.0,
                ),
                title: Center(
                  child: const Text(
                    'Edit Contacts List',
                    style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                  ),
                ),
                onTap: () {
                  print('Hello world tap');
                  DialogHelper.contactedit(context);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ListTile(
                trailing: Icon(
                  Icons.login,
                  color: Colors.pink,
                  size: 30.0,
                ),
                title: Center(
                  child: const Text('Your contact details',
                      style: TextStyle(fontSize: 20, color: Colors.blueGrey)),
                ),
                onTap: () {
                  print('Contact Details');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ListTile(
                trailing: Icon(
                  Icons.medical_services,
                  color: Colors.pink,
                  size: 30.0,
                ),
                title: Center(
                  child: const Text('Medication',
                      style: TextStyle(fontSize: 20, color: Colors.blueGrey)),
                ),
                onTap: () {
                  print('Contact Details');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Medicine()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ListTile(
                trailing: Icon(
                  Icons.location_history_rounded,
                  color: Colors.pink,
                  size: 30.0,
                ),
                title: Center(
                  child: const Text('Request child track',
                      style: TextStyle(fontSize: 20, color: Colors.blueGrey)),
                ),
                onTap: () async {
                  await trackrequest();
                },
              ),
            ),
            SizedBox(
              height: 350,
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  UserSimplePreferences.setLoggedIn(false);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomeFrame()));
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  backgroundColor: Colors.pink,
                  primary: Colors.white,
                ),
                child: Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> trackrequest() async {
    Position parent = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (UserSimplePreferences.checkDeviceID()) {
      UserSimplePreferences.trackCount();
      int counter = UserSimplePreferences.getCount()!;
      print('Track requested\n$counter');
      String time = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
      ParentChild.initial(
        time: time,
        latitude: parent.latitude.toString(),
        longitude: parent.longitude.toString(),
        childDevID: UserSimplePreferences.getDeviceID()!,
        request: true,
        response: false,
      );
    } else {
      DialogHelper.getDeviceId(context);
    }
  }
}
