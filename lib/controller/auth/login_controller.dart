import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:chat_me/core/constant/routes.dart';
import '../../core/class/statusrequest.dart';
import '../../core/function/check_internet.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  goToForgetPassword();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;

  late TextEditingController email;
  late TextEditingController password;

  bool isshowpassword = true;

  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  @override
  login() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      try {
        if (await checkInternet()) {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: email.text, password: password.text);
          if (credential.user!.emailVerified) {
            Get.offNamed(AppRoute.homepage);
          } else {
            Get.defaultDialog(
                title: "ُWarning",
                middleText:
                    'You must verify your account.\nWe have sent a verification link to your email');
            statusRequest = StatusRequest.none;
            update();
          }
        } else {
          Get.defaultDialog(title: "ُWarning", middleText: 'offlinefailure');
          statusRequest = StatusRequest.offlinefailure;
          update();
        }
      } on FirebaseAuthException catch (e) {
        Get.defaultDialog(
            title: "ُWarning",
            middleText:
                'No user found for that email.Wrong password provided for that user.');
        statusRequest = StatusRequest.none;
        update();
      }
      update();
    }
  }

  @override
  goToSignUp() {
    Get.offNamed(AppRoute.signUp);
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
