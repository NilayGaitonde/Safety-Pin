import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safety_pin/pages/model/user.dart';
import 'package:safety_pin/profile/editprofilepage.dart';
import 'package:safety_pin/profile/userpreferences.dart';
import 'package:safety_pin/profile/widgets/appbarwidgets.dart';
import 'package:safety_pin/profile/widgets/profilewidget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = UserPreferences.myUser;
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            isEdit: isEdit,
            imagePath: user.imagePath,
            onClicked: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EditProfilePage()));
            },
          ),
          SizedBox(
            height: 24,
          ),
          buildName(user),
          SizedBox(
            height: 50,
          ),
          buildNumbers(user),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            user.number,
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );
  Widget numberTemplate(number) {
    return Card(
      color: Colors.blue,
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        // padding: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
        child: Text(
          number,
          style: TextStyle(fontSize: 28.0, color: Colors.black),
        ),
      ),
    );
  }

  Widget buildNumbers(User user) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: user.numbers
            .map((number) => Center(child: numberTemplate(number)))
            .toList(),
      );
}
