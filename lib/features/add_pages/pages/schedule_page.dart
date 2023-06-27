import 'package:flutter/material.dart';
import 'package:flutter_new_projects/common/colors.dart';
import 'package:flutter_new_projects/common/sizes.dart';
import 'package:flutter_new_projects/features/widgets/main_gradient.dart';
import 'package:intl/intl.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool? checkBoxValue;
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
  void initState() {
    super.initState();
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
            value: checkBoxValue,
            onChanged: (value) {},
            tristate: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                4,
              ),
            ),
          ),
          const Padding(
            padding: horizontal10,
            child: Icon(
              Icons.done_outlined,
              color: colorWhite,
            ),
          ),
        ],
      ),
      body: MainGradient(
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
                        value: true,
                        onChanged: (value) {},
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
                                    data: MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: true),
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
                                    data: MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: true),
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
                    controller: _titleController,
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
                    controller: _titleController,
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
    );
  }
}
