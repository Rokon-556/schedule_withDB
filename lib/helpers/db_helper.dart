import 'package:path/path.dart';
import 'package:scheduler_calendar_flutter/model/scheduler_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final String CREATE_TABLE_SCHEDULER =
  ''' create table if not exists $TABLE_SCHEDULER(
  $COL_PLACE_ID integer primary key autoincrement not null,
  $COL_PLACE_DATE text not null,
  $COL_START_TIME text not null,
  $COL_END_TIME text not null,
  $COL_PLACE_TITLE text not null,
  $COL_PLACE_DESCRIPTION text not null,
  $COL_PLACE_END_DATE text not null
  ) ''';

  static void _onCreate(Database db, int version) {
    db.execute(CREATE_TABLE_SCHEDULER);
  }

  static Future<Database> createDBScheduler() async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, 'scheduler.db');
    Database db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  static Future<int> insertSchedule(
      String tableName, Map<String, dynamic> data) async {
    final db = await createDBScheduler();
    print(data);
    var result = await db.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  static Future<List<SchedulerModel>> getSchedule() async {
    final db = await createDBScheduler();
    final List<Map<String, dynamic>> schedulerMap =
    await db.query(TABLE_SCHEDULER, orderBy: COL_PLACE_TITLE);
    return List.generate(
      schedulerMap.length,
          (index) => SchedulerModel.fromMap(
        schedulerMap[index],
      ),
    );
  }

  static Future<void> deleteSchedule(int id) async {
    final db = await createDBScheduler();
    await db.delete(
      TABLE_SCHEDULER,
      where: '$COL_PLACE_ID = ?',
      whereArgs: [id],
    );
  }

  static Future<int> updateSchedule(SchedulerModel schedulerModel) async {
    final db = await createDBScheduler();
    return await db.update(
      TABLE_SCHEDULER,
      schedulerModel.toMap(),
      where: '$COL_PLACE_ID = ?',
      whereArgs: [schedulerModel.id],
    );
  }

  static Future<SchedulerModel?> getScheduleByID(int id) async {
    final db = await createDBScheduler();
    final List<Map<String, dynamic>> schedule = await db.query(
      TABLE_SCHEDULER,
      where: '$COL_PLACE_ID = ? ',
      whereArgs: [id],
    );
    if (schedule.length > 0) {
      return SchedulerModel.fromMap(schedule.first);
    }
    return null;
  }
}