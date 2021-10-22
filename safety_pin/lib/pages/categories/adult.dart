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
                    Text(
                      'Hello,',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '${UserSimplePreferences.getName()}',
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                decoration: BoxDecoration(color: Colors.pink),
              )),
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
            title: const Text(
              'Call help',
              style: TextStyle(fontSize: 15),
            ),
            onTap: () async {
              print('Help tap');
              await UrlLauncher.launch('tel: +91 9987207322');
            },
          ),
          SizedBox(
            height: 523,
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
      )),
    );
  }
}
