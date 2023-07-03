import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_new_projects/features/models/note_model.dart';
import 'package:flutter_new_projects/features/models/schedule_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeRepositoryProvider = Provider(
  (ref) => HomeRepository(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance),
);

class HomeRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  HomeRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  Stream<List<NoteModel>> getNoteListStream() {
    return firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("notes")
        .orderBy("isPinned", descending: true)
        .snapshots()
        .map((event) {
      List<NoteModel> notes = [];
      for (var docs in event.docs) {
        NoteModel noteModel = NoteModel.fromMap(docs.data());
        notes.add(noteModel);
      }
      return notes;
    });
  }
    Stream<List<ScheduleModel>> getScheduleListStream() {
    return firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("schedule")
        .orderBy("startTime", descending: true)
        .snapshots()
        .map((event) {
      List<ScheduleModel> schedules = [];
      for (var docs in event.docs) {
        ScheduleModel scheduleModel = ScheduleModel.fromMap(docs.data());
        schedules.add(scheduleModel);
      }
      return schedules;
    });
  }
}
