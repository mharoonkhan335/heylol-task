import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:heylolTask/modules/authentication/screens/auth/controller.dart';
import 'package:mobx/mobx.dart';
import 'videos.dart';
import 'package:heylolTask/modules/home/screens/video_page/controller.dart';

class VideoPage extends StatefulWidget {
  String category;
  VideoPage({this.category});
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  AuthController authController = Modular.get<AuthController>();
  VideoPageController videoPageController = Modular.get<VideoPageController>();
  String userID;
  final userRef = Firestore.instance.collection('users');
  final allVideosRef = Firestore.instance.collection('videos');

  @override
  void initState() {
    // setUserID();
    userID = authController.user.uid;
    videoPageController.getUnlockedVideos(userRef, userID, widget.category);
    // print(widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Observer(
        builder: (_) =>
            // child:
            FutureBuilder(
                //Getting videos from the intended category. ANd putting in a vertical pageView
                //Ordered by Likes and date added. Where category is current category on previous pageView.
                future: userRef
                    .document(userID)
                    .collection("unlockedVideos")
                    .where("category", isEqualTo: widget.category)
                    .where("isWatched", isEqualTo: false)
                    .orderBy("likes", descending: true)
                    .orderBy("timeAdded", descending: true)
                    .getDocuments(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    List<Videos> videos = [];
                    snapshot.data.documents.forEach((doc) {
                      // var likes = getVideoLikes(doc.documentID);
                      // print(likes);
                      videos.add(Videos.fromDocument(doc, userID));
                    });
                    print('LIST ==> ${videoPageController.prop}');
                    print("Videos LENGTH: ${videos.length}");

                    return PageView(
                      scrollDirection: Axis.vertical,
                      children: videos,
                    );
                  }
                }),
      ),
    );
  }
}
