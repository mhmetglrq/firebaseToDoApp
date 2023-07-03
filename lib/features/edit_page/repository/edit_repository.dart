import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_new_projects/features/models/note_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editRepositoryProvider = Provider(
  (ref) => EditRepository(
      firebaseFirestore: FirebaseFirestore.instance,
      firebaseAuth: FirebaseAuth.instance),
);

class EditRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  EditRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  Future<NoteModel> getNote(String uid) async {
    return await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("notes")
        .doc(uid)
        .get()
        .then((value) => NoteModel.fromMap(value.data()!));
  }

  Future<void> editNote(String uid, NoteModel noteModel) async {
    return await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("notes")
        .doc(uid)
        .update(noteModel.toMap());
  }
}
