import 'package:flutter/material.dart';
import 'package:flutter_new_projects/common/colors.dart';
import 'package:flutter_new_projects/common/sizes.dart';
import 'package:flutter_new_projects/features/widgets/main_gradient.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../models/schedule_model.dart';
import '../controller/add_controller.dart';

class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});

  @override
  ConsumerState<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  bool isHappened = false;
  bool allDay = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String startDate = "Lütfen tarih seçiniz!";
  String finishDate = "Lütfen tarih seçiniz!";
  String startTime = "";
  String finishTime = "";
  @override
  void dispose() {
    _titleController.dispose();
    _placeController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
          Checkbox(
            value: isHappened,
            onChanged: (value) {
              setState(() {
                isHappened = !isHappened;
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                4,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              String uid = const Uuid().v4();
              var startTimeFormatted = DateFormat("hh:mm").parse(startTime);
              var startDateFormatted = DateFormat("dd.MM.y").parse(startDate);
              startDateFormatted = DateTime(
                  startDateFormatted.year,
                  startDateFormatted.month,
                  startDateFormatted.day,
                  startTimeFormatted.hour,
                  startTimeFormatted.minute);
              var finishTimeFormatted = DateFormat("hh:mm").parse(finishTime);
              var finishDateFormatted = DateFormat("dd.MM.y").parse(finishDate);
              finishDateFormatted = DateTime(
                  finishDateFormatted.year,
                  finishDateFormatted.month,
                  finishDateFormatted.day,
                  finishTimeFormatted.hour,
                  finishTimeFormatted.minute);

              ScheduleModel scheduleModel = ScheduleModel(
                  uid: uid,
                  title: _titleController.text,
                  allDay: allDay,
                  startTime: startDateFormatted,
                  finishTime: finishDateFormatted,
                  location: _placeController.text,
                  note: _noteController.text,
                  isHappened: isHappened);

              ref
                  .watch(addControllerProvider)
                  .addScheduleToFirebase(scheduleModel)
                  .whenComplete(() => Navigator.pop(context));
            },
            icon: const Icon(
              Icons.done_outlined,
              color: colorWhite,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: MainGradient(
          child: SafeArea(
            child: Padding(
              padding: scaffoldPadding,
              child: Column(
                children: [
                  const Padding(
                    padding: vertical5,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Takvim",
                        style: TextStyle(
                          color: colorWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: vertical5,
                    child: TextFormField(
                      controller: _titleController,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                        contentPadding: horizontal10,
                        fillColor: textFieldFillColor,
                        filled: true,
                        hintText: "Başlık",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: colorWhite,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: vertical5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Tüm Gün",
                          style: TextStyle(
                            color: colorWhite,
                            fontSize: 14,
                          ),
                        ),
                        Switch(
                          value: allDay,
                          onChanged: (value) {
                            setState(() {
                              allDay = !allDay;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: vertical10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Başlangıç",
                          style: TextStyle(
                            color: colorWhite,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDatePicker(
                              locale: const Locale("tr", "TR"),
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(
                                2050,
                              ),
                            ).then(
                              (value) {
                                if (value != null) {
                                  String formattedDate =
                                      DateFormat('dd.MM.y').format(value);
                                  setState(() {
                                    startDate = formattedDate;
                                  });
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder:
                                        (BuildContext context, Widget? child) =>
                                            MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: true),
                                      child: Localizations.override(
                                        context: context,
                                        locale: const Locale('tr', 'TR'),
                                        child: child!,
                                      ),
                                    ),
                                  ).then(
                                    (value) {
                                      if (value != null) {
                                        setState(
                                          () {
                                            startTime =
                                                '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
                                          },
                                        );
                                      }
                                    },
                                  );
                                }
                              },
                            );
                          },
                          child: Text(
                            "$startDate $startTime",
                            style: const TextStyle(
                              color: colorWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: vertical10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Bitiş",
                          style: TextStyle(
                            color: colorWhite,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDatePicker(
                              locale: const Locale("tr", "TR"),
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(
                                2050,
                              ),
                            ).then(
                              (value) {
                                if (value != null) {
                                  String formattedDate =
                                      DateFormat('dd.MM.y').format(value);
                                  setState(() {
                                    finishDate = formattedDate;
                                  });
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder:
                                        (BuildContext context, Widget? child) =>
                                            MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: true),
                                      child: Localizations.override(
                                        context: context,
                                        locale: const Locale('tr', 'TR'),
                                        child: child!,
                                      ),
                                    ),
                                  ).then(
                                    (value) {
                                      if (value != null) {
                                        setState(
                                          () {
                                            finishTime =
                                                '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
                                          },
                                        );
                                      }
                                    },
                                  );
                                }
                              },
                            );
                          },
                          child: Text(
                            "$finishDate $finishTime",
                            style: const TextStyle(
                              color: colorWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: vertical10,
                    child: TextFormField(
                      controller: _placeController,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                        contentPadding: horizontal10,
                        fillColor: textFieldFillColor,
                        filled: true,
                        hintText: "Yer",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: colorWhite,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: vertical10,
                    child: TextFormField(
                      controller: _noteController,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                        contentPadding: horizontal10,
                        fillColor: textFieldFillColor,
                        filled: true,
                        hintText: "Notlar",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: colorWhite,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
