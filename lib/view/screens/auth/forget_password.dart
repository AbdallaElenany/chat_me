import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth/forget_password_controller.dart';
import '../../../core/class/handling_data_viwe.dart';
import '../../../core/constant/color.dart';
import '../../../core/function/valid_input.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/customtextbodyauth.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/customtexttitleauth.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPasswordControllerImp());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.backgroundcolor,
          elevation: 0.0,
          title: Text('Forget Password'.tr,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: AppColor.grey)),
        ),
        body: GetBuilder<ForgetPasswordControllerImp>(
            builder: (controller) => HandlingDataRequest(
                  statusRequest: controller.statusRequest,
                  widget: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    child: Form(
                      key: controller.formstate,
                      child: ListView(children: [
                        const SizedBox(height: 20),
                        CustomTextTitleAuth(text: "Check Email".tr),
                        const SizedBox(height: 10),
                        CustomTextBodyAuth(
                            text:
                                "please Enter Your Email Address To send link to rest password"
                                    .tr),
                        const SizedBox(height: 15),
                        CustomTextFormAuth(
                          isNumber: false,
                          valid: (val) {
                            return validInput(val!, 5, 100, "email");
                          },
                          mycontroller: controller.email,
                          hinttext: "Enter Your Email".tr,
                          iconData: Icons.email_outlined,
                          labeltext: "Email".tr,
                        ),
                        CustomButtomAuth(
                            text: "check".tr,
                            onPressed: () {
                              controller.check_email();
                            }),
                        const SizedBox(height: 40),
                      ]),
                    ),
                  ),
                )));
  }
}
