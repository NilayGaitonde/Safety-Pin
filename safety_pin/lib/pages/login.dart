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
                      // Container(
                      //     padding: EdgeInsets.fromLTRB(30.0, 87.0, 0.0, 0.0),
                      //     child: Text('There',
                      //         style: TextStyle(
                      //             fontSize: 60,
                      //             // fontWeight: FontWeight.bold,
                      //             color: Colors.grey[800]))),
                      Container(
                          padding: EdgeInsets.fromLTRB(30.0, 100.0, 0.0, 0.0),
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
                    TextField(
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.pink))),
                      obscureText: true,
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