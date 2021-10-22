import 'package:flutter/material.dart';
import 'package:safety_pin/services/store.dart';

enum Age { parent, child }

class ChildParentSetup extends StatefulWidget {
  const ChildParentSetup({Key? key}) : super(key: key);

  @override
  State<ChildParentSetup> createState() => _ChildParentSetupState();
}

class _ChildParentSetupState extends State<ChildParentSetup> {
  Age? _age = Age.parent;
  String parentChild = UserSimplePreferences.getParentChild()!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 12, top: 250, right: 12),
          child: Column(
            children: [
              Text(
                'Are you a parent or are you setting this phone for your child?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              ListTile(
                title: const Text('I am setting this up for my child'),
                leading: Radio(
                  value: Age.child,
                  groupValue: _age,
                  onChanged: (Age? value) {
                    setState(() {
                      _age = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                title: const Text('This is my phone'),
                leading: Radio(
                  value: Age.parent,
                  groupValue: _age,
                  onChanged: (Age? value) {
                    setState(() {
                      _age = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    UserSimplePreferences.parentChild(_age.toString());
                    if (_age.toString() == 'Age.parent')
                      Navigator.of(context).pushNamed('/Parent');
                    else
                      Navigator.of(context).pushNamed('/Games');
                  },
                  child: Text("Let's get started"))
            ],
          ),
        ),
      ),
    );
  }
}
