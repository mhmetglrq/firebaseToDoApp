import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_new_projects/features/models/note_model.dart';
import 'package:flutter_new_projects/features/models/schedule_model.dart';
import 'package:riverpod/riverpod.dart';

final addRepositoryProvider = Provider(
  (ref) => AddRepository(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance),
);

class AddRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  AddRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  Future<void> addNoteToFirebase(NoteModel noteModel) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("notes")
        .doc(noteModel.uid)
        .set(noteModel.toMap());
  }

  Future<void> addScheduleToFirebase(ScheduleModel scheduleModel) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("schedule")
        .doc(scheduleModel.uid)
        .set(scheduleModel.toMap());
  }
}
