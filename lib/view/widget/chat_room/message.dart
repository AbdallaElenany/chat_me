import 'package:chat_me/view/widget/chat_room/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controller/chat_controller.dart';
import '../../../core/class/typ_message.dart';
import '../../../core/constant/color.dart';
import '../../../data/model/chat_model.dart';

class BuildMessage extends GetView<ChatControllerImp> {
  final int index;
  final DocumentSnapshot? documentSnapshot;
  final String reciverimg;
  final String senderimg;
  const BuildMessage(
      {super.key,
      required this.index,
      required this.documentSnapshot,
      required this.reciverimg,
      required this.senderimg});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (documentSnapshot != null) {
      ChatMessages chatMessages = ChatMessages.fromDocument(documentSnapshot!);
      if (chatMessages.idFrom == user!.uid) {
        // right side (my message)
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                chatMessages.type == MessageType.text
                    ? messageBubble(
                        chatContent: chatMessages.content,
                        color: AppColor.teal,
                        textColor: AppColor.backgroundcolor,
                        margin: const EdgeInsets.only(right: 10),
                      )
                    : chatMessages.type == MessageType.image
                        ? Container(
                            margin: const EdgeInsets.only(right: 10, top: 10),
                            child: chatImage(
                                imageSrc: chatMessages.content, onTap: () {}),
                          )
                        : const SizedBox.shrink(),
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(20),
                    child: senderimg != "null"
                        ? FadeInImage.assetNetwork(
                            placeholder: 'assets/images/loading.gif',
                            image: senderimg,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/images/as.png",
                            fit: BoxFit.fill,
                          ),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(right: 50, top: 6, bottom: 8),
              child: Text(
                DateFormat('dd MMM yyyy, hh:mm a').format(
                  DateTime.fromMillisecondsSinceEpoch(
                    int.parse(chatMessages.timestamp),
                  ),
                ),
                style: const TextStyle(
                    color: AppColor.borderColor,
                    fontSize: 12,
                    fontStyle: FontStyle.italic),
              ),
            )
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(20),
                    child: reciverimg != "null"
                        ? FadeInImage.assetNetwork(
                            placeholder: 'assets/images/loading.gif',
                            image: reciverimg,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/images/as.png",
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
                chatMessages.type == MessageType.text
                    ? messageBubble(
                        color: AppColor.teal,
                        textColor: AppColor.backgroundcolor,
                        chatContent: chatMessages.content,
                        margin: const EdgeInsets.only(left: 10),
                      )
                    : chatMessages.type == MessageType.image
                        ? Container(
                            margin: const EdgeInsets.only(left: 10, top: 10),
                            child: chatImage(
                                imageSrc: chatMessages.content, onTap: () {}),
                          )
                        : const SizedBox.shrink(),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 50, top: 6, bottom: 8),
              child: Text(
                DateFormat('dd MMM yyyy, hh:mm a').format(
                  DateTime.fromMillisecondsSinceEpoch(
                    int.parse(chatMessages.timestamp),
                  ),
                ),
                style: const TextStyle(
                    color: AppColor.borderColor,
                    fontSize: 12,
                    fontStyle: FontStyle.italic),
              ),
            )
          ],
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }
}
