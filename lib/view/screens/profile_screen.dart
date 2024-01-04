import 'package:chat_me/core/constant/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../core/class/database_service.dart';
import '../../core/constant/routes.dart';
import '../../core/constant/size_config.dart';
import '../widget/profile/body.dart';
import 'edit_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool light = true;
    SizeConfig().init(context);

    return FutureBuilder(
      future: DatabaseService().getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
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
                    Body(
                      image: snapshot.data?[0]['image'] == "null" ||
                              snapshot.data?[0]['image'] == null
                          ? const AssetImage("assets/images/as.png")
                          : NetworkImage("${snapshot.data?[0]['image']}")
                              as ImageProvider,
                      name: "${snapshot.data?[0]['name']}",
                      email: "${snapshot.data?[0]['email']}",
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
                Get.to(EditPage(
                  oldEmail: "${snapshot.data?[0]['email']}",
                  oldName: "${snapshot.data?[0]['name']}",
                  oldImage: "${snapshot.data?[0]['image']}",
                  oldPhone: "${snapshot.data?[0]['phone']}",
                  userid: "${snapshot.data?[0]['id']}",
                ));
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
        return Container(
          color: AppColor.backgroundcolor,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
