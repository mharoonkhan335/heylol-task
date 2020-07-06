import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:heylolTask/modules/authentication/screens/sign_in/controller.dart';

import '../../module.dart';

class SignIn extends StatelessWidget {
  final SignInController controller = SignInController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width * 0.7,
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        onFieldSubmitted: (input) {
                          controller.emailController.text = input;
                        },
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Enter your email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        obscureText: true,
                        onSaved: (input) {
                          controller.passwordController.text = input;
                        },
                        controller: controller.passwordController,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Enter your password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
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
                                  // ignore: unnecessary_statements
                                  controller.isSigning
                                      ? null
                                      : await controller.signIn();
                                },
                                child: Center(
                                  child: controller.isSigning
                                      ? CircularProgressIndicator()
                                      : Text(
                                          "Sign In",
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
                  Modular.to.pushNamed(AuthenticationModule.SIGNUP);
                },
                child: Column(
                  children: <Widget>[
                    Text("Don't Have an Account?"),
                    Text("Sign up!")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
