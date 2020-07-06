import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/authentication/module.dart';
import 'modules/home/module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseAuth.instance.signOut();
  runApp(ModularApp(module: MyApp()));
}

class MyApp extends MainModule {
  final authModule = AuthenticationModule();
  final homeModule = HomeModule();
  @override
  List<Bind> get binds => [
        ...authModule.binds,
        ...homeModule.binds,
      ];

  @override
  Widget get bootstrap => MaterialApp(
        onGenerateRoute: Modular.generateRoute,
        navigatorKey: Modular.navigatorKey,
        initialRoute: '/',
      );

  @override
  List<Router> get routers => [
        Router('', module: authModule),
        Router('', module: homeModule),
      ];
}
