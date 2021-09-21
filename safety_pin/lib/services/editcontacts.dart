import 'package:flutter/material.dart';
import 'package:safety_pin/services/store.dart';

class EditContacts extends StatefulWidget {
  const EditContacts({Key? key}) : super(key: key);

  @override
  State<EditContacts> createState() => _EditContactsState();
}

class _EditContactsState extends State<EditContacts> {
  final TextEditingController _editingController1 = TextEditingController();
  final TextEditingController _editingController2 = TextEditingController();
  final TextEditingController _editingController3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) {
    List<String>? numbers = ['0', '1', '2'];
    if (UserSimplePreferences.getContacts() != null) {
      List? numbers = UserSimplePreferences.getContacts();
    }
    print(numbers);
    // text
    print('Hello world dialog box');
    return Container(
      height: 372,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Text(
            'Current contacts',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(height: 20),
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
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                numbers[0] = _editingController1.text;
                numbers[1] = _editingController2.text;
                numbers[2] = _editingController3.text;
                print(UserSimplePreferences.getContacts());
                UserSimplePreferences.setContact(numbers);
                Navigator.of(context).pushReplacementNamed('/BothPages');
              },
              child: Text('Done'))
        ],
      ),
    );
  }
}
