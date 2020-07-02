import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:heylolTask/modules/authentication/logic/repository.dart';
import 'package:heylolTask/modules/authentication/screens/auth/controller.dart';
import 'package:heylolTask/modules/home/data/videos_model.dart';
import 'package:heylolTask/modules/home/screens/home_page/controller.dart';
import 'package:video_player/video_player.dart';

import 'videos.dart';

class VideoPage extends StatefulWidget {
  String category;
  VideoPage({this.category});
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  AuthController authController = Modular.get<AuthController>();
  HomeController homeController;
  String userID;
  final userRef = Firestore.instance.collection('users');

  @override
  void initState() {
    // setUserID();
    userID = authController.user.uid;
    // print(widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        //Getting videos from the intended category. ANd putting in a vertical pageView
        //Ordered by Likes and date added. Where category is current category on previous pageView. and filtering videos that aren't watched
          future: userRef
              .document(userID)
              .collection('unlockedVideos')
              .where("category", isEqualTo: widget.category)
              .where("isWatched", isEqualTo: false)
              .orderBy('likes', descending: true)
              .orderBy("timeAdded", descending: true)
              .getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Container(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator()));
            } else {
              print("Documents LENGTH: ${snapshot.data.documents.length}");
              List<Videos> videos = [];
              snapshot.data.documents.forEach((doc) {
                videos.add(Videos.fromDocument(doc, userID));
              });
              print("Videos LENGTH: ${videos.length}");

              return PageView(
                scrollDirection: Axis.vertical,
                children: videos,
              );
            }
          }),
    );
  }
}
