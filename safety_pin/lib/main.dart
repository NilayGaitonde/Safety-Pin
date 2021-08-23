import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:safety_pin/pages/home.dart';
import 'package:safety_pin/pages/landingpage.dart';
void main() {
	runApp(MaterialApp(
		home: Scroller()
	));
}

class Scroller extends StatelessWidget {
	const Scroller({ Key? key }) : super(key: key);
    // static const Color rgbColor=const Color.rgb(216,15,43);

	@override
	Widget build(BuildContext context) {
		final PageController controller=PageController(initialPage: 0);
        return PageView(
            controller: controller,
            children: [
                Center(
                    child: LandingPage()
                ),
                Center(
                    child: Test1()
                )
            ],
        );
	}
}