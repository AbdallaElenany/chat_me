import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeController extends GetxController {
  next();
  onPageChanged(int index);
}

class HomeControllerImp extends HomeController {
  User? user = FirebaseAuth.instance.currentUser;
  late PageController pageController;
  int currentPage = 0;
  int indexPage = 0;
  List<String> categoriesname = [
    "Messages",
    "Groups",
  ];

  @override
  next() {
    pageController.animateToPage(currentPage,
        duration: const Duration(milliseconds: 900), curve: Curves.easeInOut);
  }

  @override
  onPageChanged(int index) {
    update();
    currentPage = index;
    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }
}
