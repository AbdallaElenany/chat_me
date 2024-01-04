/*import 'package:chat_me/core/constant/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../core/constant/routes.dart';
import '../../core/constant/size_config.dart';
import 'controller/profile_controller.dart';
import 'data/model/user_model.dart';
import 'view/widget/profile/body.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    //User? user = FirebaseAuth.instance.currentUser;
    //CollectionReference users = FirebaseFirestore.instance.collection('users');
    final UserModel user;
    bool light = true;
    SizeConfig().init(context);
    Get.put(ProfileControllerImp());
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.primaryColor,
        leading: const SizedBox(),
        // On Android it's false by default
        centerTitle: true,
        title: const Text("Profile"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const Body(
                image: "assets/images/as.png",
                name: "'name']}",
                email: "'email']}",
              ),
              const SizedBox(height: 50),
              ListTile(
                leading: const Icon(Icons.sunny),
                title: const Text(
                  "Light mode",
                ),
                trailing: Switch(
                  value: light,
                  activeColor: Colors.red,
                  onChanged: (bool value) {
                    light = value;
                  },
                ),
              ),
              const Divider(),
              const ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(
                    "Settings Language",
                  )),
              const Divider(),
              const ListTile(
                leading: Icon(
                  Icons.chat_outlined,
                ),
                title: Text(
                  "Help Center",
                ),
              ),
              const Divider(),
              InkWell(
                onTap: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  googleSignIn.disconnect();
                  await FirebaseAuth.instance.signOut();
                  Get.offNamed(AppRoute.login);
                },
                child: const ListTile(
                  leading: Icon(Icons.output_rounded),
                  title: Text(
                    "Sign Out",
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /* Get.to( EditPage(
            oldEmail: ,
            oldName: ,
            oldPhone: ,
            userid: ,
          ));*/
        },
        child: Text(
          "Edit",
          style: TextStyle(
            color: Colors.white,
            fontSize: SizeConfig.defaultSize! * 1.6,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
*/
