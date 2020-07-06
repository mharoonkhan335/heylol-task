import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:heylolTask/modules/authentication/logic/repository.dart';
import 'package:heylolTask/modules/home/screens/video_page/controller.dart';

class HomeRepository {
  AuthenticationRepository authRepo = Modular.get<AuthenticationRepository>();
  VideoPageController videoPageController = Modular.get<VideoPageController>();
  Future getUnlockedCategories() async {
    //returns a list of the unlocked categories of a user
    final currentUser = await authRepo.getCurrentUser();
    final userRef = await Firestore.instance
        .collection('users')
        .document(currentUser.uid)
        .get();
    print(userRef);
    return userRef.data['unlockedCategory'];
  }

  setIsWatched(String userID, String videoID, bool isWatched) async {
    //flag the video to be watched
    final userRef = Firestore.instance.collection('users').document(userID);
    await userRef
        .collection('unlockedVideos')
        .document(videoID)
        .updateData({"isWatched": isWatched});
  }

  liked(String videoID, String userID, VideoPageController controller) async {

    //Liking a video and incrementing the like count on the database.
    
    final videoRef = Firestore.instance.collection('videos').document(videoID);
    try {
      final videoDoc = await videoRef.get();
      final likedBy = videoDoc['likedBy'];
      print(likedBy);
      if (!likedBy.contains(userID)) {
        int videoLikes = videoDoc['likes'];
        videoLikes++;
        
        await videoRef.updateData({
          "likes": videoLikes,
          "likedBy": FieldValue.arrayUnion([userID])
        });
        controller.likes++;
      } else {
        print("ALREADY LIKED");
      }
    } catch (e) {
      print("Error Liking Video: $e");
    }
  }
}
