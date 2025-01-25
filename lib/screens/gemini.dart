import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class GeminiLogo extends StatelessWidget {
  const GeminiLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 150, 
            height: 150, 
            child: RiveAnimation.asset(
              'assets/icons/gemini.riv',
              fit: BoxFit.contain, 
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }
}
