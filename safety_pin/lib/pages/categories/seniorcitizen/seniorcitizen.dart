import 'package:flutter/material.dart';
import 'package:safety_pin/helpers/dialogHelper.dart';
import 'package:safety_pin/pages/Welcome.dart';
import 'package:safety_pin/pages/categories/seniorcitizen/medicine/medicine.dart';
import 'package:safety_pin/pages/home.dart';
import 'package:safety_pin/pages/profilepage.dart';
// import 'package:safety_pin/profile/profilepage.dart';
import 'package:safety_pin/services/store.dart';

class SeniorCitizen extends StatelessWidget {
  const SeniorCitizen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Align(
            alignment: Alignment(-0.3, 0.0),
            child:
                Text('SENIOR CITIZEN', style: TextStyle(color: Colors.white))),
      ),
      body: MyApp(),
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
              child: ElevatedButton(
                onPressed: () {
                  UserSimplePreferences.setLoggedIn(false);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomeFrame()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink, // background
                ),
                child: Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
