import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'home_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  final _welcomeText = "Welcome To Your Bad Journal App";
  final _nextText = "Press to Continue";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      },
      child: Scaffold(
        backgroundColor: Colors.lightGreenAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Lottie.asset('assets/animation_gif/flying_loading.json',
                  height: 250, width: 250),
              Text(_welcomeText),
              Text(_nextText),
            ],
          ),
        ),
      ),
    );
  }
}
