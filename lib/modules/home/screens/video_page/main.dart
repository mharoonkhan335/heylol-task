import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:heylolTask/modules/authentication/screens/auth/controller.dart';
import 'videos.dart';
import 'package:heylolTask/modules/home/screens/video_page/controller.dart';

class VideoPage extends StatefulWidget {
  final String category;
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
  var prop;
  List<Videos> videos = [];
  var querySnapshot;

  @override
  void initState() {
    // setUserID();
    userID = authController.user.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder(
      future: videoPageController.getUnlockedVideos(
          userRef, userID, widget.category),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          var videos = snapshot.data;
          return PageView(
            scrollDirection: Axis.vertical,
            children: videos,
          );
        }
      },
    )

        // FutureBuilder(
        //     //Getting videos from the intended category. ANd putting in a vertical pageView
        //     //Ordered by Likes and date added. Where category is current category on previous pageView.
        //     future: userRef
        //         .document(userID)
        //         .collection("unlockedVideos")
        //         .where("category", isEqualTo: widget.category)
        //         .where("isWatched", isEqualTo: false)
        //         .orderBy("likes", descending: true)
        //         .orderBy("timeAdded", descending: true)
        //         .getDocuments(),
        //     builder: (context, snapshot) {
        //       if (!snapshot.hasData) {
        //         return Center(
        //           child: Container(
        //             width: 50,
        //             height: 50,
        //             child: CircularProgressIndicator(),
        //           ),
        //         );
        //       } else {
        //         List<Videos> videos = [];
        //         print("VIDEOS ONE");
        //         snapshot.data.documents.forEach((doc) {
        //           // var likes = getVideoLikes(doc.documentID);
        //           // print(likes);
        //           videos.add(Videos.fromDocument(doc, userID));
        //         });
        //         // print('LIST ==> ${videoPageController.prop}');
        //         print("Videos LENGTH: ${videos.length}");
        //         print("VIDEOS TWO");
        //         return Observer(
        //           builder: (_) => Center(
        //             child: Text(videoPageController.prop.toString(), style:
        //                             TextStyle(color: Colors.white, fontSize: 17),),
        //           ),
        //         );
        //         // return PageView(
        //         //   scrollDirection: Axis.vertical,
        //         //   children: videos,
        //         // );
        //       }
        //     }),

        // ),
        );
  }
}
