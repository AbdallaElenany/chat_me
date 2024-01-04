import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/function/check_internet.dart';

abstract class ForgetPasswordController extends GetxController {
  check_email();
}

class ForgetPasswordControllerImp extends ForgetPasswordController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  StatusRequest statusRequest = StatusRequest.none;

  late TextEditingController email;

  @override
  check_email() async {
    if (formstate.currentState!.validate()) {
      try {
        if (await checkInternet()) {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);

          Get.defaultDialog(
              title: "ُWarning",
              middleText:
                  'We have sent your email a link through which you can change your password');

          // Get.offNamed(AppRoute.login);
        } else {
          Get.defaultDialog(title: "ُWarning", middleText: 'offlinefailure');
          statusRequest = StatusRequest.offlinefailure;
          update();
        }
      } catch (e) {
        Get.defaultDialog(
            title: "ُWarning", middleText: 'No user found for that email.');
        statusRequest = StatusRequest.none;
        update();
      }
    }
    update();
  }

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
