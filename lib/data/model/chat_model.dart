import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessages {
  final String idFrom;
  final String idTo;
  final String timestamp;
  final String content;
  int type;

  ChatMessages(
      {required this.idFrom,
      required this.idTo,
      required this.timestamp,
      required this.content,
      required this.type});

  Map<String, dynamic> toJson() {
    return {
      "idFrom": idFrom,
      "idTo": idTo,
      "timestamp": timestamp,
      "content": content,
      "type": type,
    };
  }

  factory ChatMessages.fromDocument(DocumentSnapshot documentSnapshot) {
    String idFrom = documentSnapshot.get("idFrom");
    String idTo = documentSnapshot.get("idTo");
    String timestamp = documentSnapshot.get("timestamp");
    String content = documentSnapshot.get("content");
    int type = documentSnapshot.get("type");

    return ChatMessages(
        idFrom: idFrom,
        idTo: idTo,
        timestamp: timestamp,
        content: content,
        type: type);
  }
}
