import 'package:flutter/material.dart';
import 'package:flutter_new_projects/common/colors.dart';
import 'package:flutter_new_projects/common/paths.dart';
import 'package:flutter_new_projects/common/sizes.dart';
import 'package:flutter_new_projects/features/home_page/controller/home_controller.dart';
import 'package:flutter_new_projects/features/models/note_model.dart';
import 'package:flutter_new_projects/features/models/schedule_model.dart';
import 'package:flutter_new_projects/features/widgets/main_gradient.dart';
import 'package:flutter_new_projects/router/app_route_name.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';

import '../../widgets/custom_calendar.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDialFabWidget(
        primaryIconExpand: Icons.add_outlined,
        primaryIconCollapse: Icons.close_outlined,
        secondaryIconsList: const [
          Icons.note_outlined,
          Icons.calendar_month_outlined,
        ],
        secondaryBackgroundColor: Colors.transparent,
        secondaryForegroundColor: colorWhite,
        secondaryIconsText: const [
          "Not",
          "Takvim",
        ],
        secondaryIconsOnPress: [
          () => Navigator.pushNamed(context, AppRouteName.notePage),
          () => Navigator.pushNamed(context, AppRouteName.schedulePage),
        ],
      ),
      body: MainGradient(
        child: SafeArea(
          child: Padding(
            padding: scaffoldPadding,
            child: Column(
              children: [
                Padding(
                  padding: vertical20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "on.Time",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 31,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: horizontal10,
                            child: GestureDetector(
                              onTap: () {},
                              child: SvgPicture.asset(ringPath),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(threeDotPath),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: tabBarBGColor,
                        ),
                        child: Padding(
                          padding: vertical5,
                          child: TabBar(
                            onTap: (index) {
                              setState(() {
                                _selectedTab = index;
                              });
                            },
                            indicatorWeight: 0,
                            dividerColor: Colors.transparent,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: mainColor,
                            ),
                            labelColor: colorWhite,
                            unselectedLabelColor: colorWhite,
                            tabs: const [
                              Tab(
                                child: Padding(
                                  padding: horizontal30,
                                  child: Text("Takvim"),
                                ),
                              ),
                              Tab(
                                child: Padding(
                                  padding: horizontal30,
                                  child: Text("Not"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Builder(
                        builder: (_) {
                          if (_selectedTab == 0) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height - 194,
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: vertical10,
                                    child: CustomCalendar(),
                                  ),
                                  const Align(
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
                                  Expanded(
                                    child: StreamBuilder<List<ScheduleModel>>(
                                      stream: ref
                                          .watch(homeControllerProvider)
                                          .getScheduleListStream(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          List<ScheduleModel> schedules =
                                              snapshot.data;
                                          return ListView.builder(
                                            itemCount: schedules.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              ScheduleModel scheduleModel =
                                                  schedules[index];

                                              String startTime = DateFormat(
                                                      "dd.MM.y hh:mm")
                                                  .format(
                                                      scheduleModel.startTime);
                                              String finishTime = DateFormat(
                                                      "dd.MM.y hh:mm")
                                                  .format(
                                                      scheduleModel.finishTime);

                                              return Padding(
                                                padding: vertical5,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: scheduleModel
                                                            .isHappened
                                                        ? scheduleHappenedColor
                                                        : scheduleNotHappenedColor,
                                                  ),
                                                  child: Padding(
                                                    padding: allPadding15,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              scheduleModel
                                                                  .title,
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    colorWhite,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Checkbox(
                                                              value: scheduleModel
                                                                  .isHappened,
                                                              splashRadius: 0,
                                                              onChanged:
                                                                  (value) {},
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  4,
                                                                ),
                                                              ),
                                                              side:
                                                                  const BorderSide(
                                                                color:
                                                                    colorWhite,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const Divider(
                                                          color: dividerColor,
                                                        ),
                                                        Text(
                                                          "Saat: $startTime - $finishTime",
                                                          style:
                                                              const TextStyle(
                                                            color: colorWhite,
                                                            fontSize: 14,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          "Yer: ${scheduleModel.location}",
                                                          style:
                                                              const TextStyle(
                                                            color: colorWhite,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Notlar: ${scheduleModel.note}",
                                                          style:
                                                              const TextStyle(
                                                            color: colorWhite,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return const Center(
                                          child: Text(
                                              "Bir hata ile karşılaşıldı!"),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ); //1st custom tabBarView
                          } else {
                            return Padding(
                              padding: vertical10,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 220,
                                child: StreamBuilder<List<NoteModel>>(
                                  stream: ref
                                      .watch(homeControllerProvider)
                                      .getNoteListStream(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<NoteModel> notes = snapshot.data!;
                                      return ListView.builder(
                                        itemCount: notes.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          NoteModel note = notes[index];
                                          return GestureDetector(
                                            onTap: () => Navigator.pushNamed(
                                              context,
                                              AppRouteName.editPage,
                                              arguments: {
                                                "noteModel": note,
                                              },
                                            ),
                                            child: Padding(
                                              padding: vertical5,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: noteColor,
                                                ),
                                                child: Padding(
                                                  padding: allPadding15,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        note.title,
                                                        style: const TextStyle(
                                                          color: colorWhite,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: vertical5,
                                                        child: Text(
                                                          note.note,
                                                          style:
                                                              const TextStyle(
                                                            color: colorWhite,
                                                            fontSize: 14,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: vertical5,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              note.date,
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    colorWhite,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons.push_pin,
                                                              color: note
                                                                      .isPinned
                                                                  ? colorWhite
                                                                  : noteColor,
                                                              size: 20,
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return const Center(
                                      child: Text("Bir hata ile karşılaşıldı!"),
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
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
