import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common/colors.dart';

class CustomCalendar extends StatelessWidget {
  const CustomCalendar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      headerStyle: const HeaderStyle(
        leftChevronPadding: EdgeInsets.zero,
        rightChevronPadding: EdgeInsets.zero,
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          color: colorWhite,
        ),
      ),
      locale: 'tr_TR',
      daysOfWeekHeight: 20,
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: colorWhite),
        weekendStyle: TextStyle(color: colorWhite),
      ),
      calendarStyle: CalendarStyle(
        weekendTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 14,
              color: colorWhite,
            ),
        todayTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 14,
              color: colorWhite,
            ),
        defaultTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 14,
              color: colorWhite,
            ),
        outsideDaysVisible: false,
      ),
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.now(),
      focusedDay: DateTime.now(),
      startingDayOfWeek: StartingDayOfWeek.monday,
      formatAnimationCurve: Curves.bounceInOut,
    );
  }
}
