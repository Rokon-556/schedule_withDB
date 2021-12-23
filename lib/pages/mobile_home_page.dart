import 'package:flutter/material.dart';
import 'package:scheduler_calendar_flutter/helpers/db_helper.dart';
import 'package:scheduler_calendar_flutter/model/scheduler_model.dart';
import 'package:scheduler_calendar_flutter/pages/day_view_page.dart';
import 'package:scheduler_calendar_flutter/widget/schedule_item.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../extension.dart';


class MobileHomePage extends StatefulWidget {
  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {

  List<SchedulerModel> scheduleList = [];
  CalendarFormat format = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  getScheduleList(){
    DBHelper.getSchedule().then((sList) {
      setState(() {
        scheduleList=sList;
        print('scheduleList');
        print(scheduleList);
      });
    });
  }
  @override
  void initState() {
    getScheduleList();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Calendar Page"),
        centerTitle: true,
      ),
      body:Column(

        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _selectedDay,
            daysOfWeekVisible: true,
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(
                    () {
                  format = _format;
                },
              );
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                _selectedDay = selectDay;
                _focusedDay = focusDay;
                Navigator.of(context).pushRoute(DayViewPageDemo());
              });
              print(focusDay);
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(_focusedDay, date);
            },
            calendarStyle: const CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              formatButtonDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ScheduleItem(scheduleList[index]);
              },
              itemCount: scheduleList.length,
            ),
          )
        ],
      ),
    );
  }
}
// Center(
// child: ElevatedButton(
// onPressed: () => context.pushRoute(DayViewPageDemo()),
// child: Text("Day View"),
// ),
// ),