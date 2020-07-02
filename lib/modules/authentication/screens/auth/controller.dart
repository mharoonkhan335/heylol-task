import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:heylolTask/modules/authentication/data/user.dart';
import 'package:heylolTask/modules/authentication/logic/repository.dart';
import 'package:mobx/mobx.dart';
part 'controller.g.dart';

class AuthController extends _AuthController with _$AuthController {}

abstract class _AuthController with Store {
  final repo = Modular.get<AuthenticationRepository>();
  User userData;
  @observable
  FirebaseUser user;

  @observable
  bool isSet = false;

  @observable
  String userID;

  @action
  Future setUserID () async {
    userID = await repo.getUserID();
  }

  @action
  Future getCurrentUser() async {
    user = await repo.getCurrentUser();
  }

  @action
  Future checkIsSet() async {
    final checkUser = await repo.getCurrentUser();
    if (checkUser == null) {
      print(user);
      print(checkUser);
      isSet = false;
    } else {
      try {
        final userDoc = await repo.getUserDoc(checkUser.uid);
        print(userDoc);
        final userData = User.fromJson(userDoc);
        print("${userData.name} === ${userData.isSet}");
        isSet = userData.isSet ? true : false;
        print(isSet);
      } catch (e) {
        print("GETTING USER DOC ERROR: $e");
      }
    }
  }

  @action
  Future setUser(FirebaseUser fUser) async {
    user = fUser;
  }

  @action
  Future logOut() async {
    await FirebaseAuth.instance.signOut();
    user = null;
  }
}
