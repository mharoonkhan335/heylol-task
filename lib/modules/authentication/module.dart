import 'package:flutter_modular/flutter_modular.dart';
import 'package:heylolTask/modules/authentication/logic/repository.dart';
import 'package:heylolTask/modules/authentication/screens/auth/main.dart';
import 'package:heylolTask/modules/authentication/screens/sign_in/main.dart';
import 'package:heylolTask/modules/authentication/screens/sign_up/main.dart';

import 'screens/auth/controller.dart';
import 'screens/set_interests/main.dart';

class AuthenticationModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AuthenticationRepository()),
        Bind((i) => AuthController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => AuthScreen()),
        Router(SIGNIN, child: (_, args) => SignIn()),
        Router(SIGNUP, child: (_, args) => SignUp()),
        Router(SETINTERESTS, child: (_, args) => SetInterests())
      ];

  static const SIGNIN = 'signIn/';
  static const SIGNUP = 'signUp/';
  static const SETINTERESTS = 'setInterests/';
}
