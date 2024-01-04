import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_me/controller/auth/signup_controller.dart';
import 'package:chat_me/core/function/alert_exitapp.dart';
import 'package:chat_me/core/function/valid_input.dart';
import 'package:chat_me/view/widget/auth/custombuttonauth.dart';
import 'package:chat_me/view/widget/auth/customtextbodyauth.dart';
import 'package:chat_me/view/widget/auth/customtextformauth.dart';
import 'package:chat_me/view/widget/auth/customtexttitleauth.dart';
import 'package:chat_me/view/widget/auth/textsignup.dart';
import 'package:chat_me/view/widget/background.dart';
import '../../../core/class/handling_data_viwe.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpControllerImp());
    return Background(
      topImage: "assets/images/signup_top.png",
      child: WillPopScope(
        onWillPop: alertExitApp,
        child: GetBuilder<SignUpControllerImp>(
          builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Container(
              height: 800,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              child: Form(
                key: controller.formstate,
                child: ListView(children: [
                  const Text("Sign UP",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 30),
                  const CustomTextTitleAuth(
                    text: "Welcome Back",
                  ),
                  const SizedBox(height: 10),
                  const CustomTextBodyAuth(
                      text:
                          "Sign In Your Email And Password Or  Continue With Social Media"),
                  const SizedBox(height: 30),
                  CustomTextFormAuth(
                    isNumber: false,
                    valid: (val) {
                      return validInput(val!, 3, 20, "username");
                    },
                    mycontroller: controller.username,
                    hinttext: "Enter Your Username",
                    iconData: Icons.person_outline,
                    labeltext: "Username",
                  ),
                  CustomTextFormAuth(
                    isNumber: false,
                    valid: (val) {
                      return validInput(val!, 5, 100, "email");
                    },
                    mycontroller: controller.email,
                    hinttext: "Enter Your Email",
                    iconData: Icons.email_outlined,
                    labeltext: "Email",
                  ),
                  CustomTextFormAuth(
                    isNumber: true,
                    valid: (val) {
                      return validInput(val!, 7, 11, "phone");
                    },
                    mycontroller: controller.phone,
                    hinttext: "Enter Your Phone",
                    iconData: Icons.phone_android_outlined,
                    labeltext: "Phone",
                  ),
                  CustomTextFormAuth(
                    isNumber: false,
                    valid: (val) {
                      return validInput(val!, 3, 30, "password");
                    },
                    mycontroller: controller.password,
                    hinttext: "Enter Your Password",
                    iconData: Icons.lock_outline,
                    labeltext: "Password",
                  ),
                  CustomButtomAuth(
                      text: "Sign Up",
                      onPressed: () {
                        controller.signUp();
                      }),
                  const SizedBox(height: 40),
                  CustomTextSignUpOrSignIn(
                    textone: "have an account ? ",
                    texttwo: "SignIn",
                    onTap: () {
                      controller.goToSignIn();
                    },
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
