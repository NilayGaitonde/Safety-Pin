import 'package:flutter/material.dart';
import 'package:safety_pin/services/store.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final TextEditingController _editingController1 = TextEditingController();
  final TextEditingController _editingController2 = TextEditingController();
  final TextEditingController _editingController3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<String>? numbers = ['0', '0', '0'];
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Current contacts',
              style: TextStyle(
                color: Colors.pink,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                // decoration: ,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
              child: Text('Enter your 3 emergency contacts below.',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]))),
          SizedBox(height: 30),
          Container(
            child: new Image.asset('assets/call-01.png'),
          ),
          SizedBox(height: 30),
          SizedBox(
            width: 270,
            child: TextFormField(
              controller: _editingController1,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                icon: Icon(Icons.phone),
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
                labelText: "Phone number",
                hintText: "100",
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 270,
            child: TextFormField(
              controller: _editingController2,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                icon: Icon(Icons.phone),
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
                labelText: "Phone number",
                hintText: "121",
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 270,
            child: TextFormField(
              controller: _editingController3,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                icon: Icon(Icons.phone),
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
                labelText: "Phone number",
                hintText: "1091",
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          TextButton(
            child: Text(
              'DONE',
              style: TextStyle(fontSize: 18),
            ),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 130),
              backgroundColor: Colors.pink,
              primary: Colors.white,
            ),
            onPressed: () {
              numbers[0] = _editingController1.text;
              numbers[1] = _editingController2.text;
              numbers[2] = _editingController3.text;
              print(UserSimplePreferences.getContacts());
              UserSimplePreferences.setContact(numbers);
              Navigator.of(context).pushReplacementNamed('/BothPages');
            },
          )
        ],
      ),
    );
  }
}
