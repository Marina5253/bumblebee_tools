import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class ToDoDB {
  List toDoTasks = [];

  final toDoBox = Hive.box('ToDo');

  void createTutorialTasks() {
    toDoTasks = [
      ["Welcome","Welcome text", false, DateFormat("HH:mm, dd-MM-yy").format(DateTime.now())]
    ];
  }

  void loadData() {
    toDoTasks = toDoBox.get("ToDoTasks");
  }

  void updateDB() {
    toDoBox.put("ToDoTasks", toDoTasks);
  }
}
