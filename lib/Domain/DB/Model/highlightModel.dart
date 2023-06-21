import 'package:cloud_firestore/cloud_firestore.dart';

class highlightModel {
  final String Highlightuid;
  final List<String> UidList;
  final String caption;
  final String userUid;
  final String coverUrl;
  highlightModel(
      {required this.Highlightuid,
      required this.UidList,
      required this.userUid,
      required this.coverUrl,
      required this.caption});
  Map<String, dynamic> tojson() => {
        'Highlightuid': Highlightuid,
        'UidList': UidList,
        'caption': caption,
        'coverUrl':coverUrl,
      };

  static highlightModel fromSnap(DocumentSnapshot snap) {
    //convert user snapshot to userdataObj
    var snapshot = snap.data() as Map<String, dynamic>;
    return highlightModel(
      coverUrl: snapshot['coverUrl'],
        userUid: snapshot['userUid'],
        Highlightuid: snapshot['Highlightuid'],
        UidList: snapshot['UidList'],
        caption: snapshot['caption']);
  }
}
