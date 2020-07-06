import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:heylolTask/modules/authentication/logic/repository.dart';
import 'package:heylolTask/modules/authentication/module.dart';
import 'package:heylolTask/modules/authentication/screens/auth/controller.dart';
import 'package:mobx/mobx.dart';
part 'controller.g.dart';

class SignUpController extends _SignUpController with _$SignUpController {}

abstract class _SignUpController with Store {
  final repo = Modular.get<AuthenticationRepository>();
  final auth = Modular.get<AuthController>();
  String email, password, name;
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

  @observable
  bool isSigningUp = false;

  @action
  Future<void> signUp() async {
    isSigningUp = true;
    if (signUpKey.currentState.validate()) {
      signUpKey.currentState.save();

      final userRegistry = {
        "name": name,
        "email": email,
        "isSet": false,
        "interestCategory": [],
        "unlockedCategory": [],
        "joined": DateTime.now(),
        "watchedCount": 0
      };
      final user = await repo.signUpUser(userRegistry, password);
      auth.setUser(user);
      Modular.to.pop();
    }
    isSigningUp = false;
  }
}
