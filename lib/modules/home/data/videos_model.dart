import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  String videoURL;
  String thumbnailURL;
  int likes;
  String timeAdded;
  String category;

  VideoModel.fromJson (DocumentSnapshot doc) {
    this.videoURL = doc['videoURL'];
    this.thumbnailURL = doc['thumbnailURL'];
    this.likes = doc['likes'];
    this.timeAdded = doc['timeAdded'].toString();
    this.category = doc['category'];
  }
}