import 'package:chat_me/core/constant/color.dart';
import 'package:chat_me/view/screens/list_users.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../../core/class/database_service.dart';
import '../../core/constant/routes.dart';
import '../widget/home_page/category_selector.dart';
import '../widget/home_page/customslidercategory.dart';
import 'add_group.dart';

class HomePage extends GetView<HomeControllerImp> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    return FutureBuilder(
      future: DatabaseService().getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        return Scaffold(
            backgroundColor: AppColor.borderColor,
            appBar: AppBar(
              elevation: 0.0,
              leading: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoute.profile);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(20),
                        child: snapshot.connectionState ==
                                ConnectionState.waiting
                            ? Image.asset('assets/images/loading.gif')
                            : snapshot.data?[0]['image'] != "null" ||
                                    snapshot.data?[0]['image'] != null
                                ? FadeInImage.assetNetwork(
                                    placeholder: 'assets/images/loading.gif',
                                    image: snapshot.data?[0]['image'],
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    "assets/images/as.png",
                                    fit: BoxFit.fill,
                                  ),
                      ),
                    ),
                  )),
              title: const Center(
                child: Text(
                  "Chats",
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search, size: 30.0),
                  onPressed: () {},
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  const Expanded(
                    child: CategorySelector(),
                  ),
                  Expanded(
                    flex: 8,
                    child: CustomSliderCategory(
                      userid: "${snapshot.data?[0]['id']}",
                      userimage: "${snapshot.data?[0]['image']}",
                    ),
                  )
                ],
              ),
            ),
            floatingActionButton: GetBuilder<HomeControllerImp>(
              builder: (controller) => FloatingActionButton(
                onPressed: () {
                  controller.currentPage == controller.indexPage
                      ? snapshot.connectionState == ConnectionState.waiting
                          ? Container(
                              color: AppColor.backgroundcolor,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Get.to(ListUser(
                              userid: "${snapshot.data?[0]['id']}",
                              userimage: "${snapshot.data?[0]['image']}",
                            ))
                      : Get.to(const AddGroup());
                },
                child: controller.currentPage == controller.indexPage
                    ? const Icon(Icons.message, size: 20.0)
                    : const Icon(Icons.group_add, size: 20.0),
              ),
            ));
      },
    );
  }
}
