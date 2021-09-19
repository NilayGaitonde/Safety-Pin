import 'package:flutter/material.dart';
import 'package:safety_pin/services/store.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final items = ['Parent/Child', 'Adult', 'Senior Citizen'];
  String value = 'Adult';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Which best describes you?'),
          centerTitle: true,
        ),
        body: Center(
            child: Container(
          width: 300,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 200),
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                value: value,
                iconSize: 36,
                isExpanded: true,
                elevation: 5,
                icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                items: items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() {
                  this.value = value!;
                }),
              ),
              SizedBox(height: 10),
              TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    backgroundColor: Colors.blue,
                    primary: Colors.white),
                child: Text(
                  'Log In',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  UserSimplePreferences.setCategory(this.value);
                  UserSimplePreferences.setLoggedIn(true);
                  print(UserSimplePreferences.getCategory());
                  Navigator.of(context).pushReplacementNamed('/BothPages');
                },
              )
            ],
          ),
        )));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ));
}
