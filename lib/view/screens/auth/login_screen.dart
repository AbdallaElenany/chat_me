import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:chat_me/controller/auth/login_controller.dart';
import 'package:chat_me/core/constant/icons.dart';
import 'package:chat_me/core/constant/image.dart';
import 'package:chat_me/core/function/alert_exitapp.dart';
import 'package:chat_me/core/function/valid_input.dart';
import 'package:chat_me/view/widget/auth/custombuttonauth.dart';
import 'package:chat_me/view/widget/auth/customtextbodyauth.dart';
import 'package:chat_me/view/widget/auth/customtextformauth.dart';
import 'package:chat_me/view/widget/auth/customtexttitleauth.dart';
import 'package:chat_me/view/widget/auth/textsignup.dart';
import 'package:chat_me/view/widget/background.dart';
import '../../../controller/auth/google_auth.dart';
import '../../../core/class/handling_data_viwe.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return Background(
      topImage: "assets/images/login_top.png",
      child: WillPopScope(
        onWillPop: alertExitApp,
        child: GetBuilder<LoginControllerImp>(
          builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Container(
              height: 800,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              child: Form(
                key: controller.formstate,
                child: ListView(children: [
                  const Text("Login",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  SvgPicture.asset(
                    AppImageAsset.loginImageLogo,
                    width: 120,
                    height: 120,
                  ),
                  const SizedBox(height: 30),
                  const CustomTextTitleAuth(
                    text: "Welcome Back",
                  ),
                  const SizedBox(height: 10),
                  const CustomTextBodyAuth(
                      text:
                          "Sign In Your Email And Password Or  Continue With Social Media"),
                  const SizedBox(height: 15),
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
                  GetBuilder<LoginControllerImp>(
                    builder: (controller) => CustomTextFormAuth(
                      obscureText: controller.isshowpassword,
                      onTapIcon: () {
                        controller.showPassword();
                      },
                      isNumber: false,
                      valid: (val) {
                        return validInput(val!, 5, 30, "password");
                      },
                      mycontroller: controller.password,
                      hinttext: "Enter Your Password",
                      iconData: Icons.lock_outline,
                      labeltext: "Password",
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.goToForgetPassword();
                    },
                    child: const Text(
                      "Forget Password ?",
                      textAlign: TextAlign.right,
                    ),
                  ),
                  CustomButtomAuth(
                      text: "Sign In",
                      onPressed: () {
                        controller.login();
                      }),
                  const SizedBox(height: 20),
                  CustomTextSignUpOrSignIn(
                    textone: "Dont Have An Account ? ",
                    texttwo: "Sign Up",
                    onTap: () {
                      controller.goToSignUp();
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                signInWithGoogle();
                              },
                              child: SvgPicture.asset(
                                AppIconsAsset.google,
                                width: 50,
                                height: 50,
                                color: Colors.red,
                              ))),
                      Expanded(
                          child: InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                AppIconsAsset.facebook,
                                width: 40,
                                height: 40,
                                color: Colors.blue,
                              ))),
                    ],
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
