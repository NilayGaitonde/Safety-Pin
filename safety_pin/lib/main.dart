import 'package:flutter/material.dart';
import 'package:safety_pin/pages/bothpages.dart';
import 'package:safety_pin/pages/categories/parentchild/child/childgame.dart';
import 'package:safety_pin/pages/categories/parentchild/parentsetup.dart';
// ignore: unused_import
import 'package:safety_pin/pages/home.dart';
import 'package:safety_pin/pages/login.dart';
import 'package:safety_pin/services/store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSimplePreferences.init();
  runApp(MaterialApp(
    routes: {
      '/BothPages': (context) => BothPages(),
      '/Games': (context) => Game(),
      '/Parent': (context) => SetUp()
    },
    home: CheckPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class CheckPage extends StatelessWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (UserSimplePreferences.loggedin() == true) {
      print(UserSimplePreferences.getCategory());
      return BothPages();
    } else {
      return LoginForm();
    }
  }
}
