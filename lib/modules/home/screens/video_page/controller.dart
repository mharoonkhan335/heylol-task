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
  Future<void> getLikes(videoID) async {
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

    //Getting the Like count from the specific video a user is on it...
    for (var unlockDoc in querySnapshot.documents) {
      var videoid = unlockDoc.documentID;
      var mainVideoDoc = await allVideosRef.document(videoid).get();
      Map<String, dynamic> dateAndLikes = {
        "likes": mainVideoDoc['likes'],
        "timeAdded": mainVideoDoc['timeAdded'].toString()
      };
      videos.add(Videos.fromDocument(unlockDoc, userID, dateAndLikes));
    }
    //Sorts videos on the basis of likes then date
      videos.sort((video2, video1) {
        var r = video1.sort["likes"].compareTo(video2.sort["likes"]);
        if (r != 0) return r;
        return video1.sort["timeAdded"].compareTo(video2.sort["timeAdded"]);
      });    
    return videos;
  }
}
