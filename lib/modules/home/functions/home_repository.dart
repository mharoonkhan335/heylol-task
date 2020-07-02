import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:heylolTask/modules/authentication/logic/repository.dart';
import 'package:heylolTask/modules/home/data/videos_model.dart';

class HomeRepository {
  AuthenticationRepository authRepo = Modular.get<AuthenticationRepository>();
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
    final userRef =
         Firestore.instance.collection('users').document(userID);
    await userRef.collection('unlockedVideos')
        .document(videoID)
        .updateData({"isWatched": isWatched});
  }
}
