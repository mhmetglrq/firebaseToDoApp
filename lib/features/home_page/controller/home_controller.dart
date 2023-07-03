// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_new_projects/features/home_page/repository/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/note_model.dart';
import '../../models/schedule_model.dart';

final homeControllerProvider = Provider((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return HomeController(homeRepository: homeRepository);
});

class HomeController {
  final HomeRepository homeRepository;
  HomeController({
    required this.homeRepository,
  });

  Stream<List<NoteModel>> getNoteListStream() {
    return homeRepository.getNoteListStream();
  }

  Stream<List<ScheduleModel>> getScheduleListStream() {
    return homeRepository.getScheduleListStream();
  }
}
