import 'package:flutter/material.dart';
import 'package:safety_pin/services/store.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String name = 'Friend';
  final items = ['Child & Parent', 'Adult', 'Senior Citizen'];
  String value = 'Adult';
  late String number;
  late String email;
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text('Login Page'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    // width: 350,
                    // padding: EdgeInsets.symmetric(
                    //   horizontal: 0,
                    // ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.fromLTRB(30.0, 30.0, 0.0, 0.0),
                            child: Text('Hello',
                                style: TextStyle(
                                    fontSize: 60,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.grey[800]))),
                        Container(
                            padding: EdgeInsets.fromLTRB(30.0, 87.0, 0.0, 0.0),
                            child: Text('There',
                                style: TextStyle(
                                    fontSize: 60,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.grey[800]))),
                        Container(
                            padding: EdgeInsets.fromLTRB(30.0, 140.0, 0.0, 0.0),
                            child: Text('$name.',
                                style: TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink))),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 20.0,
                      left: 30,
                      right: 30,
                    ),
                    child: Column(children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'NAME',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.pink))),
                        onChanged: (value) => setState(() {
                          name = value;
                        }),
                        validator: (value) {
                          print('Name validation');
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'PHONE NUMBER',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.pink))),
                        onChanged: (value) => setState(() {
                          number = value;
                        }),
                        validator: (value) {
                          print('Phone validation');
                          RegExp regex =
                              new RegExp(r'(\+91[\-\s]?)?[0]?(91)?[789]\d{9}$');
                          if (value!.isEmpty) {
                            print('Enter phone number');
                            return 'Enter phone number';
                          } else if (!regex.hasMatch(value)) {
                            print('Enter valid phone number');
                            return 'Enter Valid Phone Number';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.pink))),
                        onChanged: (value) => setState(() {
                          email = value;
                        }),
                        validator: (value) {
                          print('Email validation');
                          RegExp regex = new RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                          if (value!.isEmpty) {
                            return 'Enter email number';
                          } else if (!regex.hasMatch(value))
                            return 'Enter Valid Email ID';
                          else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                        value: value,
                        iconSize: 36,
                        isExpanded: true,
                        elevation: 5,
                        icon: Icon(Icons.arrow_drop_down, color: Colors.pink),
                        items: items.map(buildMenuItem).toList(),
                        onChanged: (value) => setState(() {
                          this.value = value!;
                        }),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      TextButton(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 130),
                          backgroundColor: Colors.pink,
                          primary: Colors.white,
                        ),
                        onPressed: () async {
                          print('Hello world');
                          final isValid = _formKey.currentState?.validate();
                          if (isValid == null) {
                            print('Null${_formKey.currentState?.validate()}');
                            return;
                          }
                          if (!isValid) {
                            print('Mr. Stark I dont feel so good');
                            return;
                          }
                          print('We good');
                          _formKey.currentState!.save();
                          UserSimplePreferences.setCategory(this.value);
                          UserSimplePreferences.setLoggedIn(true);
                          print(UserSimplePreferences.getCategory());
                          UserSimplePreferences.saveName(name);
                          UserSimplePreferences.saveEmail(email);
                          UserSimplePreferences.savePhone(number);
                          Navigator.of(context).pushReplacementNamed('/setup');
                        },
                      )
                      // Container(
                      //   height: 55,
                      //   child: Material(
                      //       borderRadius: BorderRadius.circular(30),
                      //       shadowColor: Colors.pinkAccent,
                      //       color: Colors.pink,
                      //       elevation: 7.0,
                      //       child: GestureDetector(
                      //         onTap: () {},
                      //         child: Center(
                      //           child: Text(
                      //             'LOGIN',
                      //             style: TextStyle(color: Colors.white),
                      //           ),
                      //         ),
                      //       )),
                      // )
                    ]),
                  )
                ]),
          ),
        ));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ));
}

                // SizedBox(height: 50),
                // Text(
                //   'What best describes you?',
                //   style: TextStyle(fontSize: 20),
                // ),
                // SizedBox(height: 50),
                // DropdownButtonFormField<String>(
                //   // decoration: const InputDecoration(border: OutlineInputBorder()),s
                //   value: value,
                //   iconSize: 36,
                //   isExpanded: true,
                //   elevation: 5,
                //   icon: Icon(Icons.arrow_drop_down, color: Colors.pink),
                //   items: items.map(buildMenuItem).toList(),
                //   onChanged: (value) => setState(() {
                //     this.value = value!;
                //   }),
                // ),
                // SizedBox(height: 50),
                // TextButton(
                //   child: Text(
                //     'Log In',
                //     style: TextStyle(fontSize: 20),
                //   ),
                //   style: TextButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(
                //         vertical: 10, horizontal: 20),
                //     backgroundColor: Colors.pink,
                //     primary: Colors.white,
                //   ),
                //   onPressed: () async {
                //     UserSimplePreferences.setCategory(this.value);
                //     UserSimplePreferences.setLoggedIn(true);
                //     print(UserSimplePreferences.getCategory());
                //     Navigator.of(context).pushReplacementNamed('/BothPages');
                //   },
                // )