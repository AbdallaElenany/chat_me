import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/edit_controller.dart';
import '../../core/class/handling_data_viwe.dart';
import '../../core/constant/color.dart';
import '../../core/function/valid_input.dart';
import '../widget/edit/custombuttonedit.dart';
import '../widget/edit/textedit.dart';
import '../widget/edit/textfieldedit.dart';

class EditPage extends StatelessWidget {
  final EditControllerImp c;
  final String oldName;
  final String oldEmail;
  final String oldImage;
  final String oldPhone;
  final String userid;
  EditPage(
      {Key? key,
      required this.oldName,
      required this.oldEmail,
      required this.oldImage,
      required this.oldPhone,
      required this.userid})
      : c = Get.put(EditControllerImp(
            oldname: oldName, oldemail: oldEmail, oldphone: oldPhone)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(EditControllerImp());
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.backgroundcolor,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 22.0,
          ),
        ),
        centerTitle: true,
        title: const Text('Edit',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                fontFamily: 'sans-serif-light',
                color: Colors.black)),
      ),
      body: GetBuilder<EditControllerImp>(
        builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: Get.height / 4,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Stack(
                          fit: StackFit.loose,
                          children: <Widget>[
                            Container(
                              width: 150.0,
                              height: 140.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: controller.file != null
                                      ? FileImage(controller.file!)
                                      : oldImage == "null" || oldImage == null
                                          ? const AssetImage(
                                              "assets/images/as.png")
                                          : NetworkImage(oldImage)
                                              as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 90.0,
                              left: 100.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 25.0,
                                child: InkWell(
                                  onTap: () async {
                                    await controller.getImage();
                                  },
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Form(
                        key: controller.formstate,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Parsonal Information',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(height: 10),
                            const TestEdit(text: 'Your Name'),
                            TestFieldEdit(
                              isNumber: false,
                              valid: (val) {
                                return validInput(val!, 5, 100, "username");
                              },
                              mycontroller: controller.name,
                            ),
                            const TestEdit(text: 'Your Email'),
                            TestFieldEdit(
                              isNumber: false,
                              valid: (val) {
                                return validInput(val!, 5, 100, "email");
                              },
                              mycontroller: controller.email,
                            ),
                            const TestEdit(text: 'Your Phone'),
                            TestFieldEdit(
                              isNumber: true,
                              valid: (val) {
                                return validInput(val!, 5, 100, "phone");
                              },
                              mycontroller: controller.phone,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 45.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: CustomButtomEdit(
                                          text: "Save",
                                          onPressed: () {
                                            controller.saveUpdate();
                                          },
                                          color: AppColor.saveColor),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: CustomButtomEdit(
                                          text: "Cancel",
                                          onPressed: () {
                                            controller.cancel();
                                          },
                                          color: AppColor.cancelColor),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
