import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  // TODO: implement binds
  List<Bind> get binds => [
        ...authModule.binds,
        ...homeModule.binds,
      ];

  @override
  // TODO: implement bootstrap
  Widget get bootstrap => MaterialApp(
        onGenerateRoute: Modular.generateRoute,
        navigatorKey: Modular.navigatorKey,
        initialRoute: '/',
      );

  @override
  // TODO: implement routers
  List<Router> get routers => [
        Router('', module: authModule),
        Router('', module: homeModule),
      ];
}
