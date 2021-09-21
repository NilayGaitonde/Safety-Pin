import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safety_pin/helpers/dialogHelper.dart';
import 'package:safety_pin/services/editcontacts.dart';
import 'package:safety_pin/services/store.dart';

class Adult extends StatelessWidget {
  const Adult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADULT'),
        centerTitle: true,
      ),
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
                decoration: BoxDecoration(color: Colors.blue),
              )),
          ListTile(
            title: const Text(
              'Edit Contacts List',
              style:
                  TextStyle(fontSize: 15, decoration: TextDecoration.underline),
            ),
            onTap: () {
              print('Hello world tap');
              DialogHelper.contactedit(context);
            },
          ),
          ListTile(
            title: const Text('Option 1'),
          ),
          SizedBox(
            height: 523,
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                UserSimplePreferences.setCategory('Null');
              },
              child: Text('Log Out'),
            ),
          ),
        ],
      )),
    );
  }
}
