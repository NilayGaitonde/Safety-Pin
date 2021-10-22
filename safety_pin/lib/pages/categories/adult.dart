import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safety_pin/helpers/dialogHelper.dart';
import 'package:safety_pin/pages/Welcome.dart';
import 'package:safety_pin/pages/home.dart';
import 'package:safety_pin/pages/profilepage.dart';
import 'package:safety_pin/services/store.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class Adult extends StatelessWidget {
  const Adult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('ADULT'),
        centerTitle: true,
      ),
      body: HereMaps(),
      drawer: Drawer(
          child: ListView(
        // padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
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
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: ListTile(
              trailing: Icon(
                Icons.call,
                color: Colors.pink,
                size: 30.0,
              ),
              title: Center(
                child: const Text(
                  'Call help',
                  style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                ),
              ),
              onTap: () async {
                print('Help tap');
                await UrlLauncher.launch('tel: +91 9987207322');
              },
            ),
          ),
          SizedBox(
            height: 480,
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
              child: Text(
                'Log Out',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
