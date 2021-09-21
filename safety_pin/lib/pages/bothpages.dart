import 'package:flutter/material.dart';
import 'package:safety_pin/pages/categories/adult.dart';
import 'package:safety_pin/pages/categories/seniorcitizen.dart';
import 'package:safety_pin/pages/home.dart';
import 'package:safety_pin/pages/landingpage.dart';
import 'package:safety_pin/services/store.dart';

import 'categories/parentchild/parent.dart';

class BothPages extends StatelessWidget {
  const BothPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget widget = GMap();
    switch (UserSimplePreferences.getCategory()) {
      case 'Adult':
        widget = new Adult();
        break;
      case 'Parent/Child':
        widget = new Parent();
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
