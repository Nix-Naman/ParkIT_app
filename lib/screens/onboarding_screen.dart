import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkassist/screens/home_screen.dart';
import 'package:parkassist/screens/loginScreen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * .5,
                child: Image.asset("assets/images/parking.png"),
              ),
              Spacer(),
              Text(
                "Parkit",
                style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "Find Parking Places \n Around You Easily",
                style: TextStyle(fontSize: 30, color: Colors.black54),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => LoginScreen(),
                )),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 5,
                        color: Colors.amber,
                      )),
                  child: Container(
                    height: height * .1,
                    width: width * .1,
                    margin: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.amber),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
