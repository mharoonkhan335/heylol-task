import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:heylolTask/modules/authentication/logic/repository.dart';
import 'package:heylolTask/modules/authentication/screens/auth/controller.dart';
import 'package:mobx/mobx.dart';
part 'controller.g.dart';

class SetInterest extends _SetInterest with _$SetInterest {}

abstract class _SetInterest with Store {
  String interests;
  GlobalKey<FormState> interestKey = GlobalKey<FormState>();
  List<String> interestList = [];
  AuthController authController =  Modular.get<AuthController>();
  AuthenticationRepository repo =  Modular.get<AuthenticationRepository>();

  @observable
  bool isSetting = false;

  @action
  Future<void> setInterests() async {
    isSetting = true;

    if (interestKey.currentState.validate()) {
      interestKey.currentState.save();
      var array = interests.split(',');
      print(array.length);
      for (int i = 0; i <= (array.length) - 1; i++) {
        // print(array[i].trim());
        interestList.add(array[i].trim());
        print(interestList);
      }
      print(interestList.sublist(0, 2));

      await repo.updateUserInterest(interestList);
      await authController.checkIsSet();

    }
    isSetting = false;
  }
}
