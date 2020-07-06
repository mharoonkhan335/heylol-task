import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:heylolTask/modules/home/functions/home_repository.dart';
import 'package:video_player/video_player.dart';
import 'controller.dart';

class Videos extends StatefulWidget {
  final String videoURL;
  final String thumbnailURL;
  final int likes;
  final Timestamp timeAdded;
  final String category;
  final videoID;
  final userID;
  final sort;
  // final dateAndLikes;

  Videos({
    this.videoURL,
    this.thumbnailURL,
    this.likes,
    this.timeAdded,
    this.category,
    this.videoID,
    this.userID,
    this.sort,
    // this.dateAndLikes
  });

  factory Videos.fromDocument(doc, userID, sort) {
    return Videos(
      videoURL: doc['videoURL'],
      thumbnailURL: doc['thumbnailURL'],
      likes: doc['likes'],
      timeAdded: doc['timeAdded'],
      category: doc['category'],
      videoID: doc.documentID,
      userID: userID,
      sort: sort,
      // dateAndLikes: dateAndLikes,
    );
  }
  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  VideoPlayerController _videoController;
  VideoPageController controller = VideoPageController();
  int videoDuration;
  int watchedDuration;
  bool isWatched = false;

  final mainVideosRef = Firestore.instance.collection('videos');

  @override
  void initState() {
    // var videoDoc = mainVideoRef.document(widget.videoID);
    controller.getLikes(widget.videoID);
    _videoController = VideoPlayerController.network(widget.videoURL)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          videoDuration = _videoController.value.duration.inSeconds;
          watchedDuration =
              (_videoController.value.duration.inSeconds * (2 / 3)).round();
          print("VIDEO DURATION: $videoDuration");
          print("WATCHED DURATION: $watchedDuration");
        });
      });

    _videoController.setLooping(true);
    _videoController.play();
    super.initState();
  }

  HomeRepository homeRepo = Modular.get<HomeRepository>();
  VideoPageController videoPageController = Modular.get<VideoPageController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Center(
            child: _videoController.value.initialized
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _videoController.value.isPlaying
                            ? _videoController.pause()
                            : _videoController.play();
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: AspectRatio(
                        aspectRatio: _videoController.value.aspectRatio,
                        child: VideoPlayer(_videoController),
                      ),
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    child: AspectRatio(
                        aspectRatio: _videoController.value.aspectRatio,
                        child: Image(
                          image: NetworkImage(widget.thumbnailURL),
                          // fit: BoxFit.cover,
                        )),
                  ),
          ),
          Positioned(
            bottom: 50,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.favorite,
                              size: 22,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              homeRepo.liked(widget.videoID, widget.userID, controller);
                            },
                          ),
                          Observer(
                            builder: (_) => Text(
                              controller.likes > 1000
                                  ? controller.likes.toString()
                                  //  "${(controller.likes / 1000).toStringAsFixed(2)}k"
                                  : controller.likes.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                          Text(
                            widget.timeAdded.toDate().toString(),
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          Text(
                            widget.videoID,
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ],
                      ),
                      ValueListenableBuilder(
                        valueListenable: _videoController,
                        builder: (context, VideoPlayerValue value, child) {
                          if (value.position.inSeconds == watchedDuration) {
                            isWatched = true;
                            homeRepo.setIsWatched(
                                widget.userID, widget.videoID, isWatched);
                          }

                          return Container();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }
}
