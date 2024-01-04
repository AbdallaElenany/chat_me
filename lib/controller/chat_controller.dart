import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/class/statusrequest.dart';
import '../core/class/typ_message.dart';
import '../data/model/chat_model.dart';

abstract class ChatController extends GetxController {
  getChatMessage(String senderId, String resiverId);
  sendChatMessage(String content, int type, String senderId, String resiverId);
}

class ChatControllerImp extends ChatController {
  late TextEditingController contentmessage;
  late final SharedPreferences prefs;

  StatusRequest statusRequest = StatusRequest.none;

  User? user = FirebaseAuth.instance.currentUser;

  File? imageFile;
  bool isLoading = false;
  bool isShowSticker = false;
  String imageUrl = '';

  Future<void> uploadImageCamera(String currentUserId, String peerId) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;
    pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        isLoading = true;
        update();
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference reference = FirebaseStorage.instance.ref().child(fileName);
        UploadTask uploadTask = reference.putFile(imageFile!);
        try {
          TaskSnapshot snapshot = await uploadTask;
          imageUrl = await snapshot.ref.getDownloadURL();
          isLoading = false;
          sendChatMessage(imageUrl, MessageType.image, currentUserId, peerId);
        } on FirebaseException catch (e) {
          isLoading = false;
          update();
          Get.defaultDialog(
              title: "ُWarning", middleText: e.message ?? e.toString());
          statusRequest = StatusRequest.offlinefailure;
          update();
        }
      }
    }
  }

  Future<void> uploadImageFile(String currentUserId, String peerId) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;
    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        isLoading = true;
        update();
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference reference = FirebaseStorage.instance.ref().child(fileName);
        UploadTask uploadTask = reference.putFile(imageFile!);
        try {
          TaskSnapshot snapshot = await uploadTask;
          imageUrl = await snapshot.ref.getDownloadURL();
          isLoading = false;
          sendChatMessage(imageUrl, MessageType.image, currentUserId, peerId);
        } on FirebaseException catch (e) {
          isLoading = false;
          update();
          Get.defaultDialog(
              title: "ُWarning", middleText: e.message ?? e.toString());
          statusRequest = StatusRequest.offlinefailure;
          update();
        }
      }
    }
  }

  @override
  void onInit() {
    contentmessage = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    contentmessage.dispose();
    super.dispose();
  }

  @override
  Stream<QuerySnapshot> getChatMessage(String senderId, String resiverId) {
    List<String> ids = [senderId, resiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return FirebaseFirestore.instance
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  @override
  void sendChatMessage(
      String content, int type, String senderId, String resiverId) {
    if (content.trim().isNotEmpty) {
      contentmessage.clear();

      ChatMessages chatMessages = ChatMessages(
          idFrom: senderId,
          idTo: resiverId,
          timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
          content: content,
          type: type);
      List<String> ids = [senderId, resiverId];
      ids.sort();
      String chatRoomId = ids.join("_");
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection("chat_rooms")
          .doc(chatRoomId)
          .collection("messages")
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(documentReference, chatMessages.toJson());
      });
    } else {
      Get.defaultDialog(title: "ُWarning", middleText: 'Nothing to send');
      statusRequest = StatusRequest.offlinefailure;
      update();
    }
  }
}
