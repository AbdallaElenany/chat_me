import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/class/statusrequest.dart';
import '../../core/function/check_internet.dart';

abstract class EditController extends GetxController {
  saveUpdate();
  getImage();
  cancel();
}

class EditControllerImp extends EditController {
  final String? oldname;
  final String? oldemail;
  final String? oldphone;
  EditControllerImp({
    this.oldemail,
    this.oldphone,
    this.oldname,
  });

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;

  late TextEditingController name = TextEditingController();
  late TextEditingController email = TextEditingController();
  late TextEditingController phone = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  File? file;
  String? url;
  XFile? image;

  @override
  saveUpdate() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      if (await checkInternet()) {
        if (file != null) {
          var imagename = basename(image!.path);
          var refstorge = FirebaseStorage.instance.ref(imagename);
          await refstorge.putFile(file!);
          url = await refstorge.getDownloadURL();
        }
        await users.doc(user!.uid).update({
          "name": name.text,
          if (url != null) "image": url,
          "email": email.text,
          "phone": phone.text,
        });
        Get.back();
        statusRequest = StatusRequest.none;
        update();
      } else {
        Get.defaultDialog(title: "ُWarning", middleText: 'offlinefailure');
        statusRequest = StatusRequest.offlinefailure;
        update();
      }
    }
    update();
  }

  @override
  cancel() {
    file = null;
    Get.back();
  }

  @override
  void onInit() {
    name.text = oldname!;
    email.text = oldemail!;
    phone.text = oldphone!;

    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  getImage() async {
    final ImagePicker picker = ImagePicker();

    image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      file = File(image!.path);
      update();
    }
    update();
  }
}
