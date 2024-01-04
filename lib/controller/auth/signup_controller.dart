import 'package:chat_me/core/class/statusrequest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:chat_me/core/constant/routes.dart';
import '../../core/class/database_service.dart';
import '../../core/function/check_internet.dart';

abstract class SignUpController extends GetxController {
  signUp();
  goToSignIn();
}

class SignUpControllerImp extends SignUpController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;

  @override
  signUp() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      try {
        if (await checkInternet()) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.text,
            password: password.text,
          );
          final result = await DatabaseService().addUser(
            userId: FirebaseAuth.instance.currentUser!.uid,
            name: username.text,
            email: email.text,
            image: "null",
            phone: phone.text,
            password: password.text,
          );
          if (result!.contains('success')) {
            FirebaseAuth.instance.currentUser!.sendEmailVerification();
            Get.offNamed(AppRoute.login);
          }
        } else {
          Get.defaultDialog(title: "ُWarning", middleText: 'offlinefailure');
          statusRequest = StatusRequest.offlinefailure;
          update();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.defaultDialog(
              title: "ُWarning",
              middleText: 'The password provided is too weak.');
          statusRequest = StatusRequest.none;
          update();
        } else if (e.code == 'email-already-in-use') {
          Get.defaultDialog(
              title: "ُWarning",
              middleText: 'The account already exists for that email.');
          statusRequest = StatusRequest.none;
          update();
        }
      } catch (e) {
        Get.defaultDialog(title: "ُWarning", middleText: "$e");
        statusRequest = StatusRequest.none;
        update();
      }
      update();
    }
  }

  @override
  goToSignIn() {
    Get.offNamed(AppRoute.login);
  }

  @override
  void onInit() {
    username = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }
}
