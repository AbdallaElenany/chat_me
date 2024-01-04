import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_me/core/constant/apptheme.dart';
import 'package:chat_me/core/services/services.dart';
import 'package:chat_me/routes.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("===============background===============");
  print(message.notification!.title);
  print(message.notification!.body);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter chat_me',
      theme: theme,
      getPages: routes,
    );
  }
}
