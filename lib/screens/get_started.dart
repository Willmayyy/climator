import 'package:climator/screens/loading_screen.dart';
import 'package:climator/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:climator/components/custom_button.dart';
import 'package:climator/components/backround_decoration.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: kBackgroundDecoration,
        constraints: const BoxConstraints.expand(),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 100.0,
              ),
              const Expanded(
                flex: 2,
                child: Image(
                  image: AssetImage('images/weather_icons/sun.png'),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              const Expanded(
                child: Text(
                  'Discover the Weather in Your City',
                  textAlign: TextAlign.center,
                  style: kLargeTextStyle,
                ),
              ),
              const Expanded(
                child: Text(
                  'Get to know your weather maps and radar precipitation forecast',
                  textAlign: TextAlign.center,
                  style: kMediumTextStyle,
                ),
              ),
              CustomButton(
                text: 'Get Started',
                kBottomMargin: 40,
                borderColor: Colors.blue.shade500,
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return LoadingScreen();
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
