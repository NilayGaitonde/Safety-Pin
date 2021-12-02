import 'package:flutter/material.dart';
import 'package:safety_pin/pages/categories/adult.dart';
import 'package:safety_pin/pages/categories/seniorcitizen/seniorcitizen.dart';
import 'package:safety_pin/pages/home.dart';
import 'package:safety_pin/pages/landingpage.dart';
import 'package:safety_pin/services/store.dart';
import 'categories/parentchild/initSetup.dart';

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
        widget = new ChildParentSetup();
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
