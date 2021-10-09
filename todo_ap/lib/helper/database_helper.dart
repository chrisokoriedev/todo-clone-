
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_ap/models/task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database _db;

  DatabaseHelper._instance();

  String tasksTable = 'task_table';
  String columnId = 'id';
  String columnTitle = 'title';
  String columnDate = 'date';
  String columnPriority = 'priority';
  String columnStatus = 'status';

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'todo_list.db';
    final todoListDb =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todoListDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $tasksTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT,$columnTitle TEXT,$columnDate TEXT,$columnPriority TEXT,$columnStatus INTEGER)',
    );
  }

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(tasksTable);
    return result;
  }

  Future<List<Task>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getTaskMapList();
    final List<Task> taskList = [];
    taskMapList.forEach((taskMap) {
      taskList.add(Task.fromMap(taskMap));
    });
    return taskList;
  }

  Future<int> insertTask(Task task) async {
    Database db = await this.db;
    final int result = await db.insert(tasksTable, task.toMap());
    return result;
  }

  Future<int> updateTask(Task task) async {
    Database db = await this.db;
    final int result = await db.update(tasksTable, task.toMap(),
        where: '$columnId=?', whereArgs: [task.id]);
    return result;
  }

  Future<int> removeTask(int id) async {
    Database db = await this.db;
    final int result =
        await db.delete(tasksTable, where: '$columnId=?', whereArgs: [id]);
    return result;
  }
}
