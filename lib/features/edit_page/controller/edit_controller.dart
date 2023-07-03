import 'package:flutter_new_projects/features/edit_page/repository/edit_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/note_model.dart';

final editControllerProvider = Provider((ref) {
  final editRepository = ref.watch(editRepositoryProvider);
  return EditController(editRepository: editRepository);
});

class EditController {
  final EditRepository editRepository;
  EditController({
    required this.editRepository,
  });

  Future<NoteModel> getNote(String uid) async {
    return await editRepository.getNote(uid);
  }

  Future<void> editNote(String uid, NoteModel noteModel) async {
    return await editRepository.editNote(uid, noteModel);
  }
}
