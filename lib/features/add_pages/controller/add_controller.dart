import 'package:flutter_new_projects/features/add_pages/repository/add_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/note_model.dart';
import '../../models/schedule_model.dart';

final addControllerProvider = Provider((ref) {
  final addRepository = ref.watch(addRepositoryProvider);
  return AddController(addRepository: addRepository);
});

class AddController {
  final AddRepository addRepository;
  AddController({
    required this.addRepository,
  });
  Future<void> addNoteToFirebase(NoteModel noteModel) async {
    return addRepository.addNoteToFirebase(noteModel);
  }

  Future<void> addScheduleToFirebase(ScheduleModel scheduleModel) async {
    return addRepository.addScheduleToFirebase(scheduleModel);
  }
}
