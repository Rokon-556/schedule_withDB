final String TABLE_SCHEDULER = 'table_schedule';
final String COL_PLACE_ID = 'place_id';
final String COL_PLACE_DATE = 'place_date';
final String COL_START_TIME = 'start_time';
final String COL_END_TIME = 'end_time';
final String COL_PLACE_TITLE = 'place_title';
final String COL_PLACE_DESCRIPTION = 'place_description';
final String COL_PLACE_END_DATE = 'place_end_date';

class SchedulerModel {
  int? id;
  String? title;
  // int? date;
  // int? startTime;
  // int? endTime;
  String? date;
  String? startTime;
  String? endTime;
  String? description;
  String? endDate;

  SchedulerModel(
      {this.id,
      this.title,
      this.date,
      this.startTime,
      this.endTime,
      this.description,
      this.endDate});

  SchedulerModel.fromMap(Map<String, dynamic> map) {
    id = map[COL_PLACE_ID];
    date = map[COL_PLACE_DATE];
    startTime = map[COL_START_TIME];
    endTime = map[COL_END_TIME];
    title = map[COL_PLACE_TITLE];
    description = map[COL_PLACE_DESCRIPTION];
    endDate = map[COL_PLACE_END_DATE];
  }

  Map<String, dynamic> toMap() {
    var scheduleMap = <String, dynamic>{
      COL_PLACE_ID: id,
      COL_PLACE_DATE: date,
      COL_START_TIME: startTime,
      COL_END_TIME: endTime,
      COL_PLACE_TITLE: title,
      COL_PLACE_DESCRIPTION: description,
      COL_PLACE_END_DATE: endDate
    };
    if (id != null) {
      scheduleMap[COL_PLACE_ID] = id;
    }
    return scheduleMap;
  }

  @override
  String toString() {
    return 'SchedulerModel{id: $id, title: $title, date: $date, startTime: $startTime, endTime: $endTime, description: $description, endDate: $endDate}';
  }
}
