import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/chat_controller.dart';
import '../../../core/class/typ_message.dart';

class MessageInput extends GetView<ChatControllerImp> {
  final String senderid;
  final String resiverid;
  const MessageInput(
      {super.key, required this.senderid, required this.resiverid});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatControllerImp());
    return GetBuilder<ChatControllerImp>(
        builder: (controller) => Container(
              height: 70.0,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.photo),
                    color: Theme.of(context).primaryColor,
                    iconSize: 20.0,
                    onPressed: () {
                      controller.uploadImageFile(senderid, resiverid);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt_outlined),
                    color: Theme.of(context).primaryColor,
                    iconSize: 20.0,
                    onPressed: () {
                      controller.uploadImageCamera(senderid, resiverid);
                    },
                  ),
                  Expanded(
                    child: TextField(
                        textInputAction: TextInputAction.send,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        controller: controller.contentmessage,
                        decoration: const InputDecoration(
                          hintText: "write here",
                          hintStyle: TextStyle(fontSize: 14),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                        )),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: Theme.of(context).primaryColor,
                    iconSize: 25.0,
                    onPressed: () {
                      controller.sendChatMessage(controller.contentmessage.text,
                          MessageType.text, senderid, resiverid);
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ],
              ),
            ));
  }
}
