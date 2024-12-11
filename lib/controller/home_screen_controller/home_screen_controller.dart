import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreenController {
  static late Database database;
  static List<Map> taskList = [];
  static initialiseDb() async {
    database = await openDatabase(
      "taskDb.db",
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            '  CREATE TABLE task(id INTEGER PRIMARY KEY,title TEXT,description TEXT,deadline TEXT)');
      },
    );
  }

  static addTask(DateTime? deadline, String title, String description) async {
    await database.rawInsert(
        'INSERT INTO task(title,description,deadline) VALUES(?, ?,?)',
        [title, description, deadline.toString()]);
    await getTask();
  }

  static deleteTask(int id) async {
    await database.rawDelete('DELETE FROM task  WHERE id=?', [id]);
    await getTask();
    log(taskList.toString());
  }

  static Future<dynamic> updateTask(
      {required String title,
      required String description,
      required DateTime? deadline,
      required int id}) async {
    await database.rawUpdate(
        'UPDATE task SET title=?,description=?,deadline=? WHERE id=?',
        [title, description, deadline.toString(), id]);
    await getTask();
  }

  static getTask() async {
    taskList = await database.rawQuery('SELECT * from task');
  }
}
