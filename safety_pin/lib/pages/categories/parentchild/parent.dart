import 'package:flutter/material.dart';

enum Age { parent, child }

class Parent extends StatefulWidget {
  const Parent({Key? key}) : super(key: key);

  @override
  State<Parent> createState() => _ParentState();
}

class _ParentState extends State<Parent> {
  Age? _age = Age.parent;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 12, top: 250, right: 12),
          child: Column(
            children: [
              Text(
                'Are you a parent or are you setting this phone for your child? $_age',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              ListTile(
                title: const Text('I am setting this up for my child'),
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
              SizedBox(height: 10),
              ListTile(
                title: const Text('This is my phone'),
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
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
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
