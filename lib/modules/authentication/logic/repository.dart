import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userRef = Firestore.instance.collection('users');
  Future<FirebaseUser> signInUser(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print("ERROR: $e");
      return null;
    }
  }
  Future<String> getUserID () async {
    final currentUser = await _auth.currentUser();
    final userID = currentUser.uid;
    return userID;
  }
  Future<FirebaseUser> getCurrentUser() async {
    return await _auth.currentUser();
  }

  Future<FirebaseUser> signUpUser(
      Map<String, Object> userRegistry, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: userRegistry['email'], password: password);
      await _userRef.document(result.user.uid).setData(userRegistry);

      return result.user;
    } catch (e) {
      print("ERROR SIGNING UP: $e");
      return null;
    }
  }

  Future getUserDoc(String userID) async {
    try {
      final userDoc = await _userRef.document(userID).get();
      return userDoc;
    } catch (e) {
      print("ERROR GETTING DOCUMENT: $e");
      return null;
    }
  }

  Future updateUserInterest (List<String> interests) async {
    //setting unlocked categories from the interest categories list of the user
    final currentUser = await getCurrentUser();
    await _userRef.document(currentUser.uid).updateData({
      'isSet': true,
      'interestCategory': interests,
      'unlockedCategory': interests.sublist(0,2)
    });
  }
}
