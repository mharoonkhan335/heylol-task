const functions = require("firebase-functions");
const admin = require("firebase-admin");
const FieldValue = require('firebase-admin').firestore.FieldValue;
admin.initializeApp();

// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

//This function is to take the videos from user's unlocked category field and put it user's collection
exports.onSettingInterests = functions.firestore
    .document("/users/{userID}")
    .onUpdate(async (change, context) => {

        
        const userDoc = change.after.data();
        const userID = context.params.userID;

        var userUnlockedCategory = userDoc['unlockedCategory'];

        const videosRef = admin.firestore().collection('videos');
        const unlockedVideosRef = admin.firestore().collection('users').doc(userID).collection('unlockedVideos');
        /* eslint-disable no-await-in-loop */
        
        //Taking videos from every category that is unlocked for user
        for (category of userUnlockedCategory) {
            await videosRef.where("category", "==", category)
                .get()
                .then((documentSnapshot) => {
                    documentSnapshot.docs.forEach((doc) => {
                        const videoData = doc.data();
                        if (videoData.watchedBy.includes(userID)) {
                            //skipping videos that are already watched by the user
                            // continue;
                        } else {
                            //if not watched by user, add to user's unlocked videos
                            unlockedVideosRef.doc(doc.id).set({
                                "category": videoData.category,
                                "likes": videoData.likes,
                                "thumbnailURL": videoData.thumbnailURL,
                                "timeAdded": videoData.timeAdded,
                                "videoURL": videoData.videoURL,
                                "isWatched": false
                            });
                        }
                    });
                    return null;
                });
        }
        /* eslint-enable no-await-in-loop */
    });
exports.onWatched = functions.firestore
    .document("/users/{userID}/unlockedVideos/{videoID}")
    .onUpdate(async (change, context) => {
        const videoDoc = change.after.data();
        const userID = context.params.userID;
        const userRef = admin.firestore().collection('users').doc(userID);
        const videoID = context.params.videoID;
        const videosRef = admin.firestore().collection('videos');
        const unlockedVideosRef = admin.firestore().collection('users').doc(userID).collection('unlockedVideos');
        const watchedVideosRef = admin.firestore().collection('users').doc(userID).collection('watchedVideos').doc(userID);

        var count;
        watchedVideosRef.get()
            .then((doc) => {
                if (doc.exists) {
                    //If the document exists, then add the value to the firebase.
                    var docData = doc.data();
                    count = docData['watchedCount'];
                    count = count + 1;

                    watchedVideosRef.update({
                        "watchedCount": count
                    });
                }

                else {
                    /* other wise if document doesn't exist, then it means user is watching his first video
                        thus creating a document for user */
                    console.log('Document Added');
                    watchedVideosRef.set({
                        "watchedCount": 1
                    });
                }
                return null;
            }).catch(error => {
                console.log(error);
            });
        
        //Unlocking the next category based on number of videos watched
        userRef.get()
            .then((doc) => {
                const userData = doc.data();
                const interestCat = userData['interestCategory'];
                const interestCatLength = interestCat.length;
                const unlockedCat = userData['unlockedCategory'];
                const unlockedCatLength = unlockedCat.length;
                
                //formula for setting the quota of number of videos watched against number of categories unlocked and it's total videos
                if (count > (unlockedCatLength * 10) * (2 / 3)) {
                    var unlock = interestCat.filter(cat => !unlockedCat.includes(cat));
                    userRef.update({
                        "unlockedCategory": FieldValue.arrayUnion(unlock[0])
                    });
                }

                return null;
            }).catch(e => {
                console.log(e);
            });

        videosRef.doc(videoID).update({
            "watchedBy": FieldValue.arrayUnion(userID)
        });
    });