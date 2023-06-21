import 'package:cloud_firestore/cloud_firestore.dart';


class Story {
  final String stroyId;
  final String username;
  final String storyImage;
  final String datePublish;
  final String userProfileUrl;
  final String userUid;
  final String timeDuration;
  final String timePublished;
  final bool IsStoryHere;
  Story(
      {required this.stroyId,
      required this.storyImage,
      required this.username,
      required this.datePublish,
      required this.userProfileUrl,
      required this.userUid,
      required this.timePublished,
      required this.timeDuration,
      required this.IsStoryHere});

  Map<String, dynamic> tojson() => {
        'username': username,
        'datePublish': datePublish,
        'storyImage': storyImage,
        'stroyId': stroyId,
        'userProfileUrl': userProfileUrl,
        'timeDuration': timeDuration,
        'userUid': userUid,
        'timePublished': timePublished,
        'IsStoryHere': IsStoryHere
      };

  static Story fromSnap(DocumentSnapshot snap) {
    //convert user snapshot to userdataObj
    var snapshot = snap.data()
        as Map<String, dynamic>; //declare Story as Map<string , dynamic>
    return Story(
      timePublished: snapshot['timePublished'],
      stroyId: snapshot['postId'],
      datePublish: snapshot['datePublish'],
      username: snapshot['username'],
      storyImage: snapshot['storyImage'],
      userProfileUrl: snapshot['userProfileUrl'],
      timeDuration: snapshot['timeDuration'],
      userUid: snapshot['userUid'],
      IsStoryHere: snapshot['IsStoryHere'],
    );
  }
}
