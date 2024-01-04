import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/home_controller.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    return GetBuilder<HomeControllerImp>(
      builder: (controller) => Container(
        height: Get.height / 10,
        color: Theme.of(context).primaryColor,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categoriesname.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                controller.onPageChanged(index);
                controller.next();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 30.0,
                ),
                child: Text(
                  controller.categoriesname[index],
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: controller.currentPage == index
                        ? Colors.white
                        : Colors.white60,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
