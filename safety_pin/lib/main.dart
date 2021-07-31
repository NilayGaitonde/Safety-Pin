import 'package:flutter/material.dart';
import 'package:safety_pin/pages/detail.dart';
import 'package:safety_pin/pages/home.dart';
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
                    child: test1()
                )
            ],
        );
	}
}