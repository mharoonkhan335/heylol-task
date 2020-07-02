import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:heylolTask/modules/authentication/screens/auth/controller.dart';
import 'package:heylolTask/modules/authentication/screens/set_interests/main.dart';
import 'package:heylolTask/modules/authentication/screens/sign_in/main.dart';
import 'package:heylolTask/modules/home/screens/home_page/main.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final controller = Modular.get<AuthController>();

  @override
  void initState() {
    controller.getCurrentUser();
    controller.checkIsSet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => controller.user == null
          ? SignIn()
          : controller.isSet
              ? Home() 
              
              // Scaffold(
              //     body: Center(
              //       child: GestureDetector(
              //         onTap: () {
              //           controller.logOut();
              //         },
              //         child: Text("Hello"),
              //       ),
              //     ),
              //   )


              : SetInterests(),
    );
  }
}
