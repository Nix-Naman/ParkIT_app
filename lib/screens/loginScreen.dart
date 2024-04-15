import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parkassist/models/park_model.dart';
import 'package:parkassist/screens/home_screen.dart';
import 'package:parkassist/screens/signupScreen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();

  final pass = TextEditingController();
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var pro = Provider.of<ParkModel>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Stack(
            children: [
              Positioned(
                top: -70,
                left: -70,
                child: SvgPicture.asset(
                  "assets/svg/blob.svg",
                ),
              ),
              Positioned(
                bottom: -70,
                right: -70,
                child: SvgPicture.asset(
                  "assets/svg/blob1.svg",
                ),
              ),
              Column(
                children: [
                  Spacer(),
                  SizedBox(
                      height: height * .35,
                      child: SvgPicture.asset("assets/svg/login.svg")),
                  SizedBox(height: height * .03),
                  SizedBox(
                    width: width * .85,
                    child: TextFormField(
                      controller: email,
                      cursorColor: Colors.amber,
                      decoration: InputDecoration()
                          .applyDefaults(Theme.of(context).inputDecorationTheme)
                          .copyWith(
                            hintText: "Email",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Icon(Icons.email_rounded),
                            ),
                          ),
                    ),
                  ),
                  SizedBox(height: height * .03),
                  SizedBox(
                    width: width * .85,
                    child: TextFormField(
                      controller: pass,
                      obscureText: isVisible,
                      cursorColor: Colors.amber,
                      decoration: InputDecoration()
                          .applyDefaults(Theme.of(context).inputDecorationTheme)
                          .copyWith(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Icon(Icons.key_rounded),
                            ),
                            hintText: 'Password',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(isVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                          ),
                    ),
                  ),
                  SizedBox(height: height * .03),
                  ElevatedButton(
                    onPressed: () {
                      pro
                          .login(email: email.text, pass: pass.text)
                          .then((value) => value
                              ? Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                  (_) => false)
                              : null);
                    },
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: height * .03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ? ",
                        style: TextStyle(
                          color: Colors.amber,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => SignupScreen()),
                              (_) => false);
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.amber
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
        size.width * 1.0, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
