import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_me/core/constant/routes.dart';
import 'package:chat_me/core/services/services.dart';

class OnboardingMiddleware extends GetMiddleware {
  @override
  int? get priority => 2;

  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getString("onboarding") == "1") {
      return const RouteSettings(name: AppRoute.login);
    }
  }
}
