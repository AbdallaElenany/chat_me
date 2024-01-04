/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../core/class/database_service.dart';
import '../data/model/user_model.dart';

abstract class ProfileController extends GetxController {
  getData();
}

class ProfileControllerImp extends ProfileController {
  @override
  Future<List<UserModel>> getData() async {
    try {
      final data = await DatabaseService().getUser();
      return data!
          .map((document) => UserModel.fromJson(document.data()))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}*/
