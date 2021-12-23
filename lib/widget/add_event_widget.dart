import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:scheduler_calendar_flutter/helpers/db_helper.dart';
import 'package:scheduler_calendar_flutter/model/scheduler_model.dart';

import '../app_colors.dart';
import '../constants.dart';
import '../extension.dart';
import '../model/event.dart';
import 'custom_button.dart';
import 'date_time_selector.dart';

class AddEventWidget extends StatefulWidget {
  final void Function(CalendarEventData<Event>)? onEventAdd;

  const AddEventWidget({
    Key? key,
    this.onEventAdd, int? scheduleID,
  }) : super(key: key);

  @override
  _AddEventWidgetState createState() => _AddEventWidgetState();
}

class _AddEventWidgetState extends State<AddEventWidget> {
  List<SchedulerModel> scheduleList = [];
  final schedule = SchedulerModel();

  late DateTime _date;

  late DateTime _startTime;

  late DateTime _endTime;

  late DateTime _endDate;

  String _title = "";

  String _description = "";

  Color _color = Colors.blue;

  late FocusNode _titleNode;

  late FocusNode _descriptionNode;

  late FocusNode _dateNode;
  late FocusNode _endDateNode;

  final GlobalKey<FormState> _form = GlobalKey();

  late TextEditingController _dateController;
  late TextEditingController _endDateController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;


  @override
  void initState() {
    super.initState();

    _titleNode = FocusNode();
    _descriptionNode = FocusNode();
    _dateNode = FocusNode();
    _endDateNode = FocusNode();

    _dateController = TextEditingController();
    _endDateController = TextEditingController();
    _startTimeController = TextEditingController();
    _endTimeController = TextEditingController();
  }

  @override
  void dispose() {
    _titleNode.dispose();
    _descriptionNode.dispose();
    _dateNode.dispose();

    _dateController.dispose();
    _endDateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: ListView(
        //mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: AppConstants.inputDecoration.copyWith(
              labelText: "Event Title",
            ),
            style: TextStyle(
              color: AppColors.black,
              fontSize: 17.0,
            ),
            onSaved: (value) {
              _title = value as String;
              //?.trim() ?? "";
              //schedule.title=value;
            },
            validator: (value) {
              if (value == null || value == "")
                return "Please enter event title.";

              return null;
            },
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(
            height: 15,
          ),
          DateTimeSelectorFormField(
            controller: _dateController,
            decoration: AppConstants.inputDecoration.copyWith(
              labelText: "Select Date",
            ),
            validator: (value) {
              if (value == null || value == "") return "Please select date.";

              return null;
            },
            textStyle: TextStyle(
              color: AppColors.black,
              fontSize: 17.0,
            ),
            onSave: (date) => _date = date,
            //DateFormat('yyyy-MM-dd HH:mm:ss').parse(date as String),
            //     DateTime.parse(
            //   DateFormat(' yyyy-MM-dd HH:mm:ss').format(
            //     DateTime.parse(
            //       date.toString(),
            //     ),
            //   ),
            // ),
            //schedule.date=_date as String,

            type: DateTimeSelectionType.date,
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: DateTimeSelectorFormField(
                  controller: _startTimeController,
                  decoration: AppConstants.inputDecoration.copyWith(
                    labelText: "Start Time",
                  ),
                  validator: (value) {
                    if (value == null || value == "")
                      return "Please select start time.";

                    return null;
                  },
                  onSave: (date) => _startTime = date,

                  textStyle: TextStyle(
                    color: AppColors.black,
                    fontSize: 17.0,
                  ),
                  type: DateTimeSelectionType.time,
                ),
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: DateTimeSelectorFormField(
                  controller: _endTimeController,
                  decoration: AppConstants.inputDecoration.copyWith(
                    labelText: "End Time",
                  ),
                  validator: (value) {
                    if (value == null || value == "")
                      return "Please select end time.";

                    return null;
                  },
                  onSave: (date) {
                    _endTime = date;
                    //schedule.endTime=_endTime as String?;
                  },
                  // DateTime.parse(
                  // DateFormat(' yyyy-MM-dd HH:mm:ss')
                  //     .format(DateTime.parse(date.toString()))),
                  //schedule.endTime=_endTime as String,

                  textStyle: TextStyle(
                    color: AppColors.black,
                    fontSize: 17.0,
                  ),
                  type: DateTimeSelectionType.time,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            focusNode: _descriptionNode,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 17.0,
            ),
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            selectionControls: MaterialTextSelectionControls(),
            minLines: 1,
            maxLines: 10,
            maxLength: 1000,
            validator: (value) {
              if (value == null || value.trim() == "")
                return "Please enter event description.";

              return null;
            },
            onSaved: (value) {
              _description = value?.trim() ?? "";
              //schedule.description=value;
            },
            decoration: AppConstants.inputDecoration.copyWith(
              hintText: "Event Description",
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          DateTimeSelectorFormField(
            controller: _dateController,
            decoration: AppConstants.inputDecoration.copyWith(
              labelText: "Select Date",
            ),
            validator: (value) {
              if (value == null || value == "") return "Please select date.";

              return null;
            },
            textStyle: TextStyle(
              color: AppColors.black,
              fontSize: 17.0,
            ),
            onSave: (date) => _endDate = date,
            //DateFormat('yyyy-MM-dd HH:mm:ss').parse(date as String),
            //     DateTime.parse(
            //   DateFormat(' yyyy-MM-dd HH:mm:ss').format(
            //     DateTime.parse(
            //       date.toString(),
            //     ),
            //   ),
            // ),
            //schedule.date=_date as String,

            type: DateTimeSelectionType.date,
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                "Event Color: ",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 17,
                ),
              ),
              GestureDetector(
                onTap: _displayColorPicker,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: _color,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          CustomButton(
            onTap: _createEvent,
            title: "Add Event",
          ),
        ],
      ),
    );
  }

  void _createEvent() {
    if (!(_form.currentState?.validate() ?? true)) return;

    _form.currentState?.save();

    final event = CalendarEventData<Event>(
      date: _date,
      color: _color,
      endTime: _endTime,
      startTime: _startTime,
      description: _description,
      title: _title,
      event: Event(
        title: _title,
      ),
    );

    widget.onEventAdd?.call(event);
    schedule.title = _title;
    schedule.description = _description;
    schedule.date = _date.toString();
    schedule.startTime = _startTime.toString();
    schedule.endTime = _endTime.toString();
    schedule.endDate=_endDate.toString();
    Future<int> id = DBHelper.insertSchedule(TABLE_SCHEDULER, schedule.toMap());
    id.then((id) {
      if (id > 0) {
        print('Saved');
      }
    });

    //_resetForm();
  }

  // void _resetForm() {
  //   _form.currentState?.reset();
  //   _dateController.text = "";
  //   _endTimeController.text = "";
  //   _startTimeController.text = "";
  // }

  void _displayColorPicker() {
    var color = _color;
    showDialog(
      context: context,
      useSafeArea: true,
      barrierColor: Colors.black26,
      builder: (_) => SimpleDialog(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(
            color: AppColors.bluishGrey,
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.all(20.0),
        children: [
          Text(
            "Event Color",
            style: TextStyle(
              color: AppColors.black,
              fontSize: 25.0,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            height: 1.0,
            color: AppColors.bluishGrey,
          ),
          ColorPicker(
            displayThumbColor: true,
            enableAlpha: false,
            pickerColor: _color,
            onColorChanged: (c) {
              color = c;
            },
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 30.0),
              child: CustomButton(
                title: "Select",
                onTap: () {
                  if (mounted)
                    setState(() {
                      _color = color;
                    });
                  context.pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}