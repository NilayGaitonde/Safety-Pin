import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safety_pin/helpers/dialogHelper.dart';
import 'package:safety_pin/pages/model/user.dart';
import 'package:safety_pin/profile/userpreferences.dart';
import 'package:safety_pin/profile/widgets/appbarwidgets.dart';
import 'package:safety_pin/profile/widgets/profilewidget.dart';
import 'package:safety_pin/profile/widgets/textformwidget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserPreferences.myUser;
  late File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            isEdit: true,
            onClicked: () {
              print('Image picker');
              pickImageFromGallery();
            },
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormWidget(
            label: 'Full Name',
            text: user.name,
            onChanged: (String value) {},
          ),
          SizedBox(height: 24.0),
          TextFormWidget(
            label: 'Email',
            text: user.email,
            onChanged: (String value) {},
          ),
          SizedBox(height: 24.0),
          TextFormWidget(
            label: 'Number',
            text: user.number,
            onChanged: (String value) {},
          ),
          SizedBox(
            height: 24.0,
          ),
          ElevatedButton(
              onPressed: () {
                DialogHelper.contactedit(context);
              },
              child: Text('Edit Contacts'))
        ],
      ),
    );
  }

  pickImageFromGallery() async {
    File image = (await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50)) as File;

    setState(() {
      _image = image;
    });
  }
}
