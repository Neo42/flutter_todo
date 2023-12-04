import 'package:flutter/material.dart';
import 'package:flutter_todo/data/database.dart';
import 'package:flutter_todo/widgets/dialog_box.dart';
import 'package:flutter_todo/widgets/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference hive box
  final _myBox = Hive.box('mybox');
  TodoDatabase db = TodoDatabase();

  // text controller
  final _controller = TextEditingController();

  @override
  void initState() {
    // create default data on the first launch ever of the app
    if (_myBox.get("TODOLIST") == null) {
      db.initDatabase();
    } else {
      db.loadDatabase();
    }
    super.initState();
  }

  void toggleCheckbox(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      Navigator.of(context).pop();
      _controller.clear();
    });
    db.updateDatabase();
  }

  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSaveTask: saveNewTask,
          onCancelTask: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text("TO DO"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChange: (value) => toggleCheckbox(value, index),
            onDeleteTask: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
