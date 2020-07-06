import 'package:flutter_modular/flutter_modular.dart';
import 'package:heylolTask/modules/home/screens/home_page/main.dart';
import 'package:heylolTask/modules/home/functions/home_repository.dart';
import 'package:heylolTask/modules/home/screens/video_page/controller.dart';

import 'screens/home_page/controller.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeRepository()),
        Bind((i) => HomeController()),
        Bind((i) => VideoPageController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => Home()),
      ];
}
