import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:safety_pin/pages/categories/adult.dart';
import 'package:safety_pin/pages/categories/parentchild/parent.dart';
import 'package:safety_pin/pages/categories/seniorcitizen.dart';
import 'package:safety_pin/pages/model/info.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';

class WelcomeController extends GetxController {
  var SelectedPageIndex = 0.obs;
  var pageController1 = PageController();

  forwardAction() {
    pageController1.nextPage(duration: 300.milliseconds, curve: Curves.ease);
  }

  List<WelcomeInfo> WelcomePages = [
    WelcomeInfo('assets/welcome.png', 'Welcome to our app',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
    WelcomeInfo('assets/child_parent.png', 'Child & Parent',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
    WelcomeInfo('assets/adult.png', 'Adult',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
    WelcomeInfo('assets/old.png', 'Senior Citizen',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
  ];
}
