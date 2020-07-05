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

    return likes;
  }

  @action
  Future<void> getUnlockedVideos(userRef, userID, category) async {
    var allVideosRef = Firestore.instance.collection('videos');
    List<Videos> videos = [];

    QuerySnapshot querySnapshot = await userRef
        .document(userID)
        .collection('unlockedVideos')
        .where("category", isEqualTo: category)
        .where('isWatched', isEqualTo: false)
        .getDocuments()
        .then((query) {
      query.documents.forEach((unlockDoc) async {
        var videoid = unlockDoc.documentID;
        await allVideosRef.document(videoid).get().then((mainVideoDoc) {
          Map<String, dynamic> dateAndLikes = {
            "likes": mainVideoDoc['likes'],
            "timeAdded": (mainVideoDoc['timeAdded'].toString())
          };
          
          prop.add(dateAndLikes);
          prop.sort((m2, m1) {
            var r = m1["likes"].compareTo(m2["likes"]);
            if (r != 0) return r;
            return m1["timeAdded"].compareTo(m2["timeAdded"]);
          });
          //  print(likesAndDate);
          //  videos.add(Videos.fromDocument(unlockDoc, userID, dateAndLikes));
        });
      });
    });

    // print("EXECUTING BELOW");
    // likesAndDate = prop;
    // print('LIKES AND DATE ==> $likesAndDate');
  }
}
