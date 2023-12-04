import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List toDoList = [];
  // reference
  final _myBox = Hive.box('mybox');

  // run on first time open this app ever
  void initDatabase() {
    toDoList = [
      ["Build", false],
      ["Deploy", false],
      ["Test", false]
    ];
  }

  // update the database
  void loadDatabase() {
    toDoList = _myBox.get("TODOLIST");
  }

  // update the database
  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
