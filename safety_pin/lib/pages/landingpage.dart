import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
				  child: Scaffold(
					  backgroundColor: Colors.redAccent[400],
					  body: Center(
					    child: Column(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
						  children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40.0, 0, 0),
                    child: Text(
                    'EMERGENCY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                    //   fontWeight: FontWeight.bold,
                    )
                  ),
                  ),
							    //   SizedBox(height: 40.0),
                  Container(
                                  height: 460.0,
                                  width: 460.0,
                    child: FittedBox(
                                      child: AvatarGlow(
                                        endRadius: 60.0,
                                        child: FloatingActionButton(
                                        onPressed: () {},
                                        child: Text(
                                            'HELP!',
                                            style: TextStyle(
                                                color: Colors.red[400]
                                            ),
                                        ),
                                        backgroundColor: Colors.white,
                                          ),
                                      ),
                                  ),
                  )
						  ],
					    ),
					  )
				  ),
				);
  }
}