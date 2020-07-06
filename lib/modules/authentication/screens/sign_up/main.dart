import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:heylolTask/modules/authentication/screens/sign_up/controller.dart';

class SignUp extends StatelessWidget {
  final SignUpController controller = SignUpController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Form(
                    key: controller.signUpKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          onSaved: (input) {
                            controller.name = input;
                          },
                          validator: (input) {
                            if (input.length < 3) {
                              return "Name too short";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          onSaved: (input) {
                            controller.email = input;
                          },
                          keyboardType: TextInputType.emailAddress,
                          validator: (input) {
                            if (!input.contains("@") ||
                                !input.contains(".com") ||
                                input.length < 9) {
                              return "Please use a valid email";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          onSaved: (input) {
                            controller.password = input;
                          },
                          validator: (input) {
                            if (input.length < 6) {
                              return "Password must be 6 or more characters long";
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green,
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: Observer(
                                builder: (_) => InkWell(
                                  onTap: () async {
                                    if (!controller.isSigningUp) {
                                      await controller.signUp();
                                    }
                                  },
                                  child: Center(
                                    child: controller.isSigningUp
                                        ? CircularProgressIndicator()
                                        : Text(
                                            "Sign Up",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Modular.to.pop();
                  },
                  child: Column(
                    children: <Widget>[
                      Text("Have an account?"),
                      Text("Sign in!")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SetInterestVideos extends StatefulWidget {
  @override
  _SetInterestVideosState createState() => _SetInterestVideosState();
}

class _SetInterestVideosState extends State<SetInterestVideos> {
  TextEditingController interestsController = TextEditingController();
  GlobalKey<FormState> interestKey = GlobalKey<FormState>();
  headToRegistration() {
    if (interestKey.currentState.validate()) {
      interestKey.currentState.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: 300,
            child: Form(
              key: interestKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    onSaved: (value) {
                      interestsController.text = value;
                    },
                    validator: (value) {
                      var array = value.split(",");
                      if (!value.contains(',')) {
                        return "Please enter only two points of interests separated by a single ','";
                      } else if (array.length > 2) {
                        return "Please only specify two points of interests";
                      } else {
                        return null;
                      }
                    },
                    controller: interestsController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      headToRegistration();
                    },
                    child: Container(
                      width: 120,
                      height: 50,
                      color: Colors.green,
                      child: Center(child: Text("Set")),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
