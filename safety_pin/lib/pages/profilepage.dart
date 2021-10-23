import 'package:flutter/material.dart';
import 'package:safety_pin/services/store.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text('PROFILE PAGE'),
          centerTitle: true,
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            buildName(),
            SizedBox(
              height: 50,
            ),
            buildNumbers(),
          ],
        ));
  }

  Widget buildName() => Column(
        children: [
          SizedBox(height: 30),
          Container(
            child: new Image.asset('assets/fox.png'),
          ),
          Text(
            UserSimplePreferences.getName()!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(height: 30),
          const SizedBox(
            height: 4,
          ),
          Text(
            UserSimplePreferences.getPhone()!,
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
          Text(
            UserSimplePreferences.getEmail()!,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );

  Widget numberTemplate(number) {
    return Card(
      color: Colors.pink,
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      shape: StadiumBorder(),
      child: Padding(
        // padding: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
        child: Text(
          number,
          style: TextStyle(fontSize: 25.0, color: Colors.white),
        ),
      ),
    );
  }

  Widget buildNumbers() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: UserSimplePreferences.getContacts()!
            .map((number) => Center(child: numberTemplate(number)))
            .toList(),
      );
}
