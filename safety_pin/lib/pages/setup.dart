import 'package:flutter/material.dart';
import 'package:safety_pin/pages/contactsetup.dart';

class SetupForm extends StatefulWidget {
  const SetupForm({Key? key}) : super(key: key);

  @override
  _SetupFormState createState() => _SetupFormState();
}

class _SetupFormState extends State<SetupForm> {
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text('Setup Account'),
          centerTitle: true,
        ),
        body: Column(
          children: [Contact()],
        ));
  }
}
