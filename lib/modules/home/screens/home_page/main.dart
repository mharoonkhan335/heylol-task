import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:heylolTask/modules/authentication/logic/repository.dart';
import 'package:heylolTask/modules/authentication/screens/auth/controller.dart';
import 'package:heylolTask/modules/home/functions/home_repository.dart';
import 'package:heylolTask/modules/home/data/videos_model.dart';
import 'package:heylolTask/modules/home/screens/video_page/main.dart';

import 'controller.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // HomeRepository homeRepo = HomeRepository();
  HomeController controller = HomeController();
  AuthController authController = Modular.get<AuthController>();
  List<VideoModel> videos;

  @override
  void initState() {
    controller.getUnlockedCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Observer(
        //Main top level Screen that then navigates to every category and every video insid the category.
        builder: (_) => Stack(
          children: <Widget>[
            PageView(
                scrollDirection: Axis.horizontal,
                //Each category mapped to PageView swiping left and right
                children: controller.unlockedCategories.map((cat) {
                  String categoryTitle = controller.capitalize(cat);
                  return Stack(
                    children: <Widget>[
                      VideoPage(
                        category: cat,
                      ),
                      Align(
                        alignment: Alignment(0.0, -0.8),
                        child: Container(
                          height: 50,
                          width: 130,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.18),
                              blurRadius: 2.0,
                            )
                          ]),
                          child: Center(
                            child: Text(
                              categoryTitle,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList()),
            Align(
              alignment: Alignment(0.88, -0.85),
              child: Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red),
                child: GestureDetector(
                  onTap: () {
                    authController.logOut();
                  },
                  child: Center(
                      child: Text("Log Out",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
