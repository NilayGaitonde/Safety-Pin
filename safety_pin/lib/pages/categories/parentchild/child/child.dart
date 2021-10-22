import 'package:flutter/material.dart';
import 'package:safety_pin/helpers/dialogHelper.dart';
import 'package:safety_pin/pages/Welcome.dart';
import 'package:safety_pin/pages/categories/parentchild/child/tracklist.dart';
import 'package:safety_pin/pages/home.dart';
import 'package:safety_pin/pages/profilepage.dart';
import 'package:safety_pin/services/store.dart';

class Child extends StatefulWidget {
  const Child({Key? key}) : super(key: key);

  @override
  _ChildState createState() => _ChildState();
}

class _ChildState extends State<Child> {
  var switchLocation = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Align(
            alignment: Alignment(-0.3, 0.0),
            child: Text('CHILD', style: TextStyle(color: Colors.white))),
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
                )),
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
                  Icons.info,
                  color: Colors.pink,
                  size: 30.0,
                ),
                title: Center(
                  child: const Text(
                    'Device Info',
                    style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                  ),
                ),
                onTap: () {
                  print('Device info');
                  DialogHelper.deviceInfo(context);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ListTile(
                trailing: Icon(
                  Icons.location_history_rounded,
                  size: 30.0,
                  color: Colors.pink,
                ),
                title: Center(
                  child: const Text(
                    'Track list',
                    style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                  ),
                ),
                onTap: () {
                  print('TRACK LIST');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TrackList()));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ListTile(
                title: Center(
                  child: const Text(
                    'Location sharing',
                    style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Switch(
                onChanged: (newVal) {
                  onSwitchValueChanged(newVal);
                  
                },
                value: switchLocation,
              ),
            ),
            SizedBox(height: 240),
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

  void onSwitchValueChanged(bool newVal) {
    setState(() {
      switchLocation = newVal;
    });
  }
}
