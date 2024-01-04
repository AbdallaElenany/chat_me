import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "../../controller/chat_controller.dart";
import "../widget/chat_room/message.dart";
import "../widget/chat_room/message_composer.dart";

class ChatScreen extends StatelessWidget {
  final String userreciver;
  final String reciverimg;
  final String reciverid;
  final String senderimg;
  final String senderid;
  const ChatScreen(
      {super.key,
      required this.userreciver,
      required this.reciverimg,
      required this.senderimg,
      required this.senderid,
      required this.reciverid});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatControllerImp());
    return GetBuilder<ChatControllerImp>(
        builder: (controller) => Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              appBar: AppBar(
                elevation: 0.0,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                title: Center(
                  child: Text(
                    userreciver,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.more_horiz, size: 30.0),
                    onPressed: () {},
                  ),
                ],
              ),
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            topLeft: Radius.circular(30.0),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            topLeft: Radius.circular(30.0),
                          ),
                          child: StreamBuilder<QuerySnapshot>(
                              stream: controller.getChatMessage(
                                  senderid, reciverid),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Text("Something went wrong");
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: Text("loading..."));
                                }
                                var listMessages = snapshot.data!.docs;
                                if (listMessages.isNotEmpty) {
                                  return ListView.builder(
                                      padding: const EdgeInsets.all(10),
                                      itemCount: snapshot.data?.docs.length,
                                      reverse: true,
                                      itemBuilder: (context, index) =>
                                          BuildMessage(
                                            index: index,
                                            documentSnapshot:
                                                snapshot.data?.docs[index],
                                            senderimg: senderimg,
                                            reciverimg: reciverimg,
                                          ));
                                } else {
                                  return const Center(
                                    child: Text('No messages...'),
                                  );
                                }
                              }),
                        ),
                      ),
                    ),
                    MessageInput(
                      senderid: senderid,
                      resiverid: reciverid,
                    ),
                  ],
                ),
              ),
            ));
  }
}
