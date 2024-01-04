import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  User? user = FirebaseAuth.instance.currentUser;
  Future<String?> addUser({
    required String name,
    required String image,
    required String phone,
    required String email,
    required String password,
    required String userId,
  }) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      // Call the user's CollectionReference to add a new user
      await users.doc(userId).set(
        {
          "id": userId,
          "name": name,
          "image": image,
          "email": email,
          "phone": phone,
          "password": password,
        },
        //SetOptions(merge: true),
      );
      return 'success';
    } catch (e) {
      return 'Error adding user';
    }
  }

  Future<List<QueryDocumentSnapshot>?> getAllUser() async {
    QuerySnapshot users = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isNotEqualTo: user!.uid)
        .get();

    return users.docs;
  }

  Future<List<QueryDocumentSnapshot>?> getUser() async {
    QuerySnapshot users = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: user!.uid)
        .get();

    return users.docs;
  }
}
