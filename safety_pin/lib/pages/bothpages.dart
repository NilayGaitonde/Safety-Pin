import 'package:flutter/material.dart';
import 'package:safety_pin/pages/categories/adult.dart';
import 'package:safety_pin/pages/categories/parentchild/parent.dart';
import 'package:safety_pin/pages/categories/seniorcitizen/seniorcitizen.dart';
import 'package:safety_pin/pages/home.dart';
import 'package:safety_pin/pages/landingpage.dart';
import 'package:safety_pin/services/store.dart';
import 'categories/parentchild/child/child.dart';
import 'categories/parentchild/intiSetup.dart';

class BothPages extends StatelessWidget {
  const BothPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget widget = HereMaps();
    print(UserSimplePreferences.getCategory());
    switch (UserSimplePreferences.getCategory()) {
      case 'Adult':
        widget = new Adult();
        break;
      case 'Child & Parent':
        if (UserSimplePreferences.getParentChild() == null) {
          widget = new ChildParentSetup();
        } else if (UserSimplePreferences.getParentChild() == 'Age.parent') {
          widget = new Parent();
        } else {
          widget = new Child();
        }
        break;
      case 'Senior Citizen':
        widget = new SeniorCitizen();
        break;
      default:
    }
    final PageController controller = PageController(initialPage: 0);

    return PageView(
      controller: controller,
      children: [
        Center(child: LandingPage()),
        Center(child: widget),
      ],
    );
  }
}
