import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<MyServices> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await Firebase.initializeApp();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    /////////////////////////subscribeToTopic/////////////////
    await FirebaseMessaging.instance.subscribeToTopic('users');
    //////////////////////////////////////////////////////////////
    /////////////////////////get token/////////////////////////
    String? token = await FirebaseMessaging.instance.getToken();
    print("======================================");
    print(token);
    //////////////////////////////////////////////////////////////
    /////////////////// forground /////////////////////////////////
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        FlutterRingtonePlayer.playNotification();
        Get.snackbar(
          message.notification!.title!,
          message.notification!.body!,
          icon: const Icon(Icons.notifications),
        );
      }
    });
///////////////////////////////////////////////////////////////////
/////////////////////Background/////////////////////////////////////

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

//////////////////////////////////////////////////////////////////////////////
    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
