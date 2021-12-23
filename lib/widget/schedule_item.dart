import 'package:flutter/material.dart';
import 'package:scheduler_calendar_flutter/helpers/db_helper.dart';
import 'package:scheduler_calendar_flutter/model/scheduler_model.dart';
import 'package:scheduler_calendar_flutter/widget/add_event_widget.dart';

class ScheduleItem extends StatefulWidget {
  final SchedulerModel schedulerModel;

  ScheduleItem(
      this.schedulerModel); //const ScheduleItem({Key? key}) : super(key: key);

  @override
  _ScheduleItemState createState() => _ScheduleItemState();
}

class _ScheduleItemState extends State<ScheduleItem> {
  void _deletePlace() async {
    await DBHelper.deleteSchedule(widget.schedulerModel.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(widget.schedulerModel.title.toString()),
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) => [
                // PopupMenuItem(
                //   child: Text('Edit'),
                //   value: 0,
                // ),
                PopupMenuItem(
                  child: Text('Delete'),
                  value: 1,
                ),
              ],
              onSelected: (value) {
                // if (value == 0) {
                //   Navigator.of(context).push(
                //     MaterialPageRoute(
                //       builder: (context) => AddEventWidget(
                //         //scheduleID: widget.schedulerModel.id,
                //       ),
                //     ),
                //   );
                // }
                //else
                  if (value == 1) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Delete'),
                        content: Text('Are You sure to Delete'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _deletePlace();
                              Navigator.of(context).pop(true);
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      ));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}