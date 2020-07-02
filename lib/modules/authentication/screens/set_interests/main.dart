import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:heylolTask/modules/authentication/screens/auth/controller.dart';
import 'package:heylolTask/modules/authentication/screens/set_interests/controller.dart';

class SetInterests extends StatefulWidget {
  @override
  _SetInterests createState() => _SetInterests();
}

class _SetInterests extends State<SetInterests> {
  SetInterest controller = SetInterest();
  AuthController authController = Modular.get<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: 300,
            child: Form(
              key: controller.interestKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Hey there!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "What videos are you interested in?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                  Text("* Separate each category with a comma",
                      style: TextStyle(color: Colors.redAccent)),
                  SizedBox(height: 5),
                  TextFormField(
                    onSaved: (value) {
                      controller.interests = value;
                    },
                    validator: (value) {
                      if (!value.contains(",")) {
                        return "Separate interests with a ','";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "e.g animals, funny, gaming, awesome, car",
                      hintStyle:
                          TextStyle(color: Colors.grey[500], fontSize: 12),
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
                      if (!controller.isSetting) {
                        controller.setInterests();
                      }
                    },
                    child: Container(
                      width: 120,
                      height: 50,
                      color: Colors.green,
                      child: Observer(
                        builder: (_) => Center(
                          child: controller.isSetting
                              ? CircularProgressIndicator()
                              : Text("Set", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold,)),
                        ),
                      ),
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
