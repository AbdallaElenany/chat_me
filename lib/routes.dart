import 'package:chat_me/test.dart';
import 'package:chat_me/view/screens/auth/forget_password.dart';
import 'package:chat_me/view/screens/edit_screen.dart';
import 'package:chat_me/view/screens/profile_screen.dart';
import 'package:get/get.dart';
import 'package:chat_me/core/constant/routes.dart';
import 'package:chat_me/view/screens/home_page.dart';
import 'package:chat_me/view/screens/onboarding.dart';
import 'package:chat_me/view/screens/auth/signup_screen.dart';
import 'core/middleware/auth_middleware.dart';
import 'core/middleware/onboarding_middleware.dart';
import 'view/screens/auth/login_screen.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      name: "/",
      page: () => const OnBoarding(),
      middlewares: [OnboardingMiddleware()]),
  GetPage(
      name: AppRoute.login,
      page: () => const Login(),
      middlewares: [AuthMiddleware()]),
  GetPage(name: AppRoute.signUp, page: () => const SignUp()),
  GetPage(name: AppRoute.forgetPassword, page: () => const ForgetPassword()),
  GetPage(name: AppRoute.homepage, page: () => const HomePage()),
  GetPage(name: AppRoute.profile, page: () => const ProfileScreen()),
  /* GetPage(name: "/", page: () => const Test()),*/
];
