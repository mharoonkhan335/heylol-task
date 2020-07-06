import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heylolTask/modules/home/screens/video_page/videos.dart';
import 'package:mobx/mobx.dart';
part 'controller.g.dart';

class VideoPageController extends _VideoPageController
    with _$VideoPageController {}

abstract class _VideoPageController with Store {
  final mainVideosRef = Firestore.instance.collection('videos');

  @observable
  List<Map<String, dynamic>> prop = [];

  @observable
  int likes = 0;

  @action
  Future<int> getLikes(videoID) async {
    var videoDoc = await mainVideosRef.document(videoID).get();
    likes = videoDoc['likes'];

    // return likes;
  }

  @action
  Future getUnlockedVideos(userRef, userID, category) async {
    var allVideosRef = Firestore.instance.collection('videos');
    List<Videos> videos = [];

    QuerySnapshot querySnapshot = await userRef
        .document(userID)
        .collection('unlockedVideos')
        .where("category", isEqualTo: category)
        .where('isWatched', isEqualTo: false)
        .getDocuments();

      querySnapshot.documents.forEach((unlockDoc) async {
        var videoid = unlockDoc.documentID;
        var mainVideoDoc = await allVideosRef.document(videoid).get();
          print("EXECUTING FOREACH");
          Map<String, dynamic> dateAndLikes = {
            "likes": mainVideoDoc['likes'],
            "timeAdded": mainVideoDoc['timeAdded'].toString()
          };
          List<Map<String, dynamic>> properties = [];
          prop.add(dateAndLikes);

          // print("PROP FIRST ==> $properties");
          prop.sort((m2, m1) {
            var r = m1["likes"].compareTo(m2["likes"]);
            if (r != 0) return r;
            return m1["timeAdded"].compareTo(m2["timeAdded"]);
          });
          // prop = properties;
          // print(prop);
          //  print(likesAndDate);
          //  videos.add(Videos.fromDocument(unlockDoc, userID, dateAndLikes));

      });
    print("EXECUTED FOR EACH");
    return prop;

    // print("EXECUTING BELOW");
    // likesAndDate = prop;
    // print('LIKES AND DATE ==> $likesAndDate');
  }
}
