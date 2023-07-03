import 'package:flutter/material.dart';
import 'package:flutter_new_projects/common/colors.dart';
import 'package:flutter_new_projects/common/sizes.dart';
import 'package:flutter_new_projects/features/add_pages/controller/add_controller.dart';
import 'package:flutter_new_projects/features/models/note_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class NotePage extends ConsumerStatefulWidget {
  const NotePage({super.key});

  @override
  ConsumerState<NotePage> createState() => _NotePageState();
}

class _NotePageState extends ConsumerState<NotePage> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  bool isPinned = false;
  @override
  void dispose() {
    _noteController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: colorWhite,
          ),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isPinned = !isPinned;
              });
            },
            icon: Icon(
              isPinned ? Icons.push_pin : Icons.push_pin_outlined,
              color: colorWhite,
            ),
          ),
          IconButton(
            onPressed: () {
              String uid = const Uuid().v4();

              String formattedDate =
                  DateFormat("dd.MM.y").format(DateTime.now());

              NoteModel noteModel = NoteModel(
                title: _titleController.text,
                uid: uid,
                note: _noteController.text,
                date: formattedDate,
                isPinned: isPinned,
              );
              ref
                  .watch(addControllerProvider)
                  .addNoteToFirebase(noteModel)
                  .whenComplete(
                    () => Navigator.pop(context),
                  );
            },
            icon: const Icon(
              Icons.done_outlined,
              color: colorWhite,
            ),
          ),
        ],
      ),
      backgroundColor: noteColor,
      body: SafeArea(
        child: Padding(
          padding: scaffoldPadding,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                style: const TextStyle(
                  fontSize: 18,
                  color: colorWhite,
                ),
                maxLines: 2,
                decoration: const InputDecoration(
                  contentPadding: horizontal10,
                  hintText: "Başlık",
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: colorWhite,
                  ),
                  border: InputBorder.none,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: vertical5,
                  child: TextFormField(
                    controller: _noteController,
                    style: const TextStyle(
                      fontSize: 14,
                      color: colorWhite,
                    ),
                    maxLines: 28,
                    decoration: const InputDecoration(
                      contentPadding: horizontal10,
                      hintText: "Notunuz...",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: colorWhite,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
