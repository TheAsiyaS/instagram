import 'package:cloud_firestore/cloud_firestore.dart';

class messageModel {
  final List<String> Message;
  final String MessageId;
  final String currentUserId;
  final String SendedUserId;
  final String Date;
  final String Time;
  final String IsUserSeen;
  final bool Isleft;

  messageModel({
    required this.Message,
    required this.Isleft,
    required this.Time,
    required this.currentUserId,
    required this.MessageId,
    required this.SendedUserId,
    required this.Date,
    required this.IsUserSeen,
  });

  Map<String, dynamic> tojson() => {
        'Message': Message,
        'MessageId': MessageId,
        'SendedUserId': SendedUserId,
        'Date': Date,
        'currentUserId': currentUserId,
        'Time': Time,
        'IsUserSeen': IsUserSeen,
        'Isleft': Isleft,
      };

  static messageModel fromSnap(DocumentSnapshot snap) {
    //convert user snapshot to userdataObj
    var snapshot = snap.data()
        as Map<String, dynamic>; //declare userdata as Map<string , dynamic>
    return messageModel(
      Message: snapshot['Message'],
      SendedUserId: snapshot['SendedUserId'],
      Date: snapshot['Date'],
      MessageId: snapshot['MessageId'],
      IsUserSeen: snapshot['IsUserSeen'],
      currentUserId: snapshot['currentUserId'],
      Isleft: snapshot['Isleft'],
      Time: snapshot['Time'],
    );
  }
}
