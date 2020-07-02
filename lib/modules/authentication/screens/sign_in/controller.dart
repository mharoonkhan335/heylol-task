import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:heylolTask/modules/authentication/logic/repository.dart';
import 'package:heylolTask/modules/authentication/screens/auth/controller.dart';
import 'package:mobx/mobx.dart';
part 'controller.g.dart';

class SignInController = _SignInController with _$SignInController;

abstract class _SignInController with Store {
  final repository = Modular.get<AuthenticationRepository>();
  final authController = Modular.get<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @observable
  bool isSigning = false;

  @action
  Future<void> signIn () async {
    isSigning = true;
    

    final user = await repository.signInUser(emailController.text, passwordController.text);
    isSigning = false;
    authController.setUser(user);

  }
}
