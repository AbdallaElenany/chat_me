import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/home_controller.dart';
import 'groups_chat.dart';
import 'messages_chats.dart';

class CustomSliderCategory extends GetView<HomeControllerImp> {
  final String userimage;
  final String userid;
  const CustomSliderCategory(
      {super.key, required this.userimage, required this.userid});

  @override
  Widget build(BuildContext context) {
    List<Widget> categories = [
      RecentChats(
        userid: userid,
        userimage: userimage,
      ),
      const GroupChats(),
    ];
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: (val) {
        controller.onPageChanged(val);
      },
      itemCount: categories.length,
      itemBuilder: (context, i) => Container(
        height: Get.height * 0.7,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: categories[i],
      ),
    );
  }
}
