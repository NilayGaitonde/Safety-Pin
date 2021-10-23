import 'package:flutter/cupertino.dart';
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
        "Welcome to 'Safety Pin' ,a safety application  created to ease your life and help you connect to your Emergency Contacts at the earliest with a trace of your live location in an emergency."),
    WelcomeInfo('assets/child_parent.png', 'Child & Parent',
        "A parent and child have a special bond. This bond shouldn't be broken. Not even if the child is far away from their parent/gaurdian. With our parent/child module we allow the parent to track the child at a moment's tap. The parent also has the medication feature."),
    WelcomeInfo('assets/adult.png', 'Adult',
        "The adult module is simple yet elegant, at the tap of a button the user can call up emergency services"),
    WelcomeInfo('assets/old.png', 'Senior Citizen',
        "Senior citizens are the backbone of our society and we strive to help them with our app. The app has a medication feature which shows the user all the medications they have listed out and are reminded on a daily basis on a time of thier choosing to take the medicine."),
  ];
}
