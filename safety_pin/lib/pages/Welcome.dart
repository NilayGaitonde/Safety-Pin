import 'package:color/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safety_pin/pages/Controller/welcome_controller.dart';
import 'package:safety_pin/pages/login.dart';

class WelcomeFrame extends StatelessWidget {
  final _contoller = WelcomeController();

  @override
  Widget build(BuildContext context) {
    var blue;
    return Scaffold(
      
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
                controller: _contoller.pageController1,
                onPageChanged: _contoller.SelectedPageIndex,
                itemCount: _contoller.WelcomePages.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                              _contoller.WelcomePages[index].imageasset),
                          SizedBox(
                            height: 32,
                          ),
                          Text(
                            _contoller.WelcomePages[index].title,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 32.0),
                            child: Text(_contoller.WelcomePages[index].desc,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18)),
                          )
                        ],
                      ),
                    ),
                  );
                }),
            Align(
                alignment: Alignment(0, -0.9),
                child: Text(
                  'Safety-Pin',
                  style: TextStyle(
                    fontFamily: 'Nunito-Regular',
                    fontSize: 50,
                    color: Colors.pink,
                    // fontWeight: FontWeight.w500,
                  ),
                )),
            Align(
              alignment: Alignment(0, 0.96),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _contoller.WelcomePages.length,
                    (index) => Obx(() {
                      return Container(
                          margin: EdgeInsets.all(4),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              color: _contoller.SelectedPageIndex.value == index
                                  ? Colors.pink
                                  : Colors.blueGrey[400],
                              shape: BoxShape.circle));
                    }),
                  )),
            ),
            Positioned(
                bottom: 40,
                right: 20,
                child: FloatingActionButton(
                  child: Text(
                    'Login',
                    // style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginForm()));
                  },
                  backgroundColor: Colors.pink,
                ))
          ],
        ),
      ),
    );
  }
}
