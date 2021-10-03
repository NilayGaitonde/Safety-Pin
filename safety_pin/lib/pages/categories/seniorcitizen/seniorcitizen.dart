import 'package:flutter/material.dart';
import 'package:safety_pin/helpers/dialogHelper.dart';
import 'package:safety_pin/pages/categories/seniorcitizen/medicine/medicine.dart';
import 'package:safety_pin/pages/home.dart';
import 'package:safety_pin/profile/profilepage.dart';
import 'package:safety_pin/services/store.dart';

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
                      Text(
                        'You have logged in as an',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '${UserSimplePreferences.getCategory()}',
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(color: Colors.pink),
                )),
            ListTile(
              title: const Text(
                'Edit Contacts List',
                style: TextStyle(fontSize: 15),
              ),
              onTap: () {
                print('Hello world tap');
                DialogHelper.contactedit(context);
              },
            ),
            ListTile(
              title: const Text('Your contact details'),
              onTap: () {
                print('Contact Details');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            ListTile(
              title: const Text('Medication'),
              onTap: () {
                print('Contact Details');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Medicine()));
              },
            )
          ],
        ),
      ),
    );
  }
}
