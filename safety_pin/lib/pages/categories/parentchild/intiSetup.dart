import 'package:flutter/material.dart';

enum Age { parent, child }

class ChildParentSetup extends StatefulWidget {
  const ChildParentSetup({Key? key}) : super(key: key);

  @override
  State<ChildParentSetup> createState() => _ChildParentSetupState();
}

class _ChildParentSetupState extends State<ChildParentSetup> {
  Age? _age = Age.parent;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 12, top: 170, right: 12),
          child: Column(
            children: [
              Text(
                'Are you a parent or are you setting this phone for your child?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 150),
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
                  activeColor: Colors.pink,
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
                  activeColor: Colors.pink,
                ),
              ),
              SizedBox(height: 140),
              ElevatedButton(
                  onPressed: () {
                    if (_age.toString() == 'Age.parent')
                      Navigator.of(context).pushNamed('/Parent');
                    else
                      Navigator.of(context).pushNamed('/Games');
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 130),
                    backgroundColor: Colors.pink,
                    primary: Colors.white,
                  ),
                  child: Text(
                    "start",
                    style: TextStyle(fontSize: 18),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
