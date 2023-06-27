import 'package:flutter/material.dart';
import 'package:flutter_new_projects/common/colors.dart';
import 'package:flutter_new_projects/common/paths.dart';
import 'package:flutter_new_projects/common/sizes.dart';
import 'package:flutter_new_projects/features/widgets/main_gradient.dart';
import 'package:flutter_new_projects/router/app_route_name.dart';
import 'package:flutter_svg/svg.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';

import '../../widgets/custom_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          () => {},
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
                  length: 2, // length of tabs
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
                            return const SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: vertical10,
                                    child: CustomCalendar(),
                                  ),
                                  Align(
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
                                ],
                              ),
                            ); //1st custom tabBarView
                          } else {
                            return const Text("Aloo"); //2nd tabView
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
