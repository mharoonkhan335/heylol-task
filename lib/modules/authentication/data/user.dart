import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String email;
  String password;
  bool isSet;
  List interestCategory;
  List unlockedCategory;
  String dateJoined;

  User.fromJson(DocumentSnapshot doc) {
    this.name = doc['name'];
    this.email = doc['email'];
    this.password = doc['password'];
    this.isSet = doc['isSet'];
    this.interestCategory = doc['interestCategory'];
    this.unlockedCategory = doc['unlockedCategory'];
    this.dateJoined = doc['dateJoined'];
  }
}
