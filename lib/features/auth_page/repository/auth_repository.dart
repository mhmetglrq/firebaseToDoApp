import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_new_projects/features/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
      firebaseFirestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance),
);

class AuthRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;
  AuthRepository({
    required this.firebaseFirestore,
    required this.auth,
  });

  Future<void> signUp(String email, String password, String fullname) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    UserModel userModel =
        UserModel(fullName: fullname, uid: auth.currentUser!.uid);
    await firebaseFirestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .set(userModel.toMap());
  }

  Future<void> signIn(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  bool checkUser() {
    return auth.currentUser != null ? true : false;
  }
}
