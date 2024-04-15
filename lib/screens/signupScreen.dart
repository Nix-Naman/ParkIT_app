import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parkassist/models/park_model.dart';
import 'package:parkassist/screens/loginScreen.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();
  final pass1 = TextEditingController();
  bool isVisible = false;
  final _formKey = GlobalKey<FormState>();
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Spacer(),
                      SizedBox(
                          height: height * .35,
                          child: SvgPicture.asset("assets/svg/signup.svg")),
                      SizedBox(height: height * .03),
                      SizedBox(
                        width: width * .85,
                        child: TextFormField(
                          controller: email,
                          validator: (value) {
                            if (value==null) {
                              return 'Please enter an email address';
                            } else if (!RegExp(
                                    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                                .hasMatch(value.toString())) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          cursorColor: Colors.amber,
                          decoration: InputDecoration()
                              .applyDefaults(
                                  Theme.of(context).inputDecorationTheme)
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
                          maxLength: 6,
                          cursorColor: Colors.amber,
                          validator: (value) {
                            if (value==null) {
                              return "Please enter a password";
                            }else if(value.length<6){
                              return "Password length must be atleast 6 character";
                            }
                            return  null;
                          },
                          decoration: InputDecoration()
                              .applyDefaults(
                                  Theme.of(context).inputDecorationTheme)
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
                      SizedBox(
                        width: width * .85,
                        child: TextFormField(
                          controller: pass1,
                          obscureText: isVisible,
                          cursorColor: Colors.amber,
                          validator: (value) {
                            if (value==null) {
                              return "Please enter a password";
                            }else if(value.length<6){
                              return "Password length must be atleast 6 character";
                            }
                            return  null;
                          },
                          decoration: InputDecoration()
                              .applyDefaults(
                                  Theme.of(context).inputDecorationTheme)
                              .copyWith(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Icon(Icons.key_rounded),
                                ),
                                hintText: 'Confirm Password',
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
                          if (_formKey.currentState!.validate()) {
                            if (pass.text==pass1.text) {
                              pro.signUp(email: email.text, pass: pass.text);
                            }else{
                              Fluttertoast.showToast(msg: "Password do not match");
                            }
                          }
                          
                        },
                        child: Text(
                          "SIGNUP",
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
                            "Already have an account ? ",
                            style: TextStyle(
                              color: Colors.amber,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (_) => false);
                            },
                            child: Text(
                              "Login",
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
                ),
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
