// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_new_projects/features/edit_page/repository/edit_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:flutter_new_projects/common/colors.dart';
import 'package:flutter_new_projects/common/sizes.dart';
import 'package:flutter_new_projects/features/models/note_model.dart';

class EditPage extends ConsumerStatefulWidget {
  const EditPage({
    super.key,
    required this.noteModel,
  });
  final NoteModel noteModel;

  @override
  ConsumerState<EditPage> createState() => _EditPageState();
}

class _EditPageState extends ConsumerState<EditPage> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  bool? isPinned;
  @override
  void dispose() {
    _noteController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _noteController.text = widget.noteModel.note;
    _titleController.text = widget.noteModel.title;
    super.initState();
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
                widget.noteModel.isPinned = !widget.noteModel.isPinned;
              });
            },
            icon: Icon(
              widget.noteModel.isPinned
                  ? Icons.push_pin
                  : Icons.push_pin_outlined,
              color: colorWhite,
            ),
          ),
          IconButton(
            onPressed: () {
              String formattedDate =
                  DateFormat("dd.MM.y").format(DateTime.now());

              NoteModel noteModel = NoteModel(
                title: _titleController.text,
                uid: widget.noteModel.uid,
                note: _noteController.text,
                date: formattedDate,
                isPinned: widget.noteModel.isPinned,
              );

              ref
                  .watch(editRepositoryProvider)
                  .editNote(widget.noteModel.uid, noteModel)
                  .whenComplete(
                () {
                  Navigator.pop(context);
                },
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
