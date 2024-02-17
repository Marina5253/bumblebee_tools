import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:bumblebee_tools/data/todo_db.dart';
import 'package:bumblebee_tools/widgets/main/drawer.dart';
import 'package:bumblebee_tools/widgets/main/rootAppBar.dart';
import 'package:bumblebee_tools/widgets/todo/dialog_box.dart';
import 'package:bumblebee_tools/widgets/todo/todo_element.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final taskNameController = TextEditingController();
  final taskTextController = TextEditingController();
  final toDoBox = Hive.box('Todo');
  ToDoDB toDoDB = ToDoDB();

  @override
  void initState() {


    if (toDoBox.get("ToDoTasks") == null) {
      toDoDB.createTutorialTasks();
    } else {
      toDoDB.loadData();
    }

    super.initState();
  }

  void itemChecked(bool? value, int index) {
    setState(() {
      toDoDB.toDoTasks[index][2] = !toDoDB.toDoTasks[index][2];
      toDoDB.updateDB();
    });
  }

  Future<void> editTodo(index) async {
    bool? result = await showDialog(
      context: context,
      builder: (context) {
        taskNameController.text = toDoDB.toDoTasks[index][0];
        taskTextController.text = toDoDB.toDoTasks[index][1];
        return DialogBox(
            nameController: taskNameController,
            textController: taskTextController);
      },
    );
    if (result == null) {
      if (taskNameController.text.isNotEmpty) {
        if (taskNameController.text != toDoDB.toDoTasks[index][0] ||
            taskTextController.text != toDoDB.toDoTasks[index][1]) {
          setState(() {
            toDoDB.toDoTasks[index][0] = taskNameController.text;
            toDoDB.toDoTasks[index][1] = taskTextController.text;
            toDoDB.toDoTasks[index][3] =
                DateFormat("HH:mm, dd-MM-yy").format(DateTime.now());
          });
          toDoDB.updateDB();
        }
      }
      clearField();
    }
  }

  void deleteTodo(int index) {
    setState(() {
      toDoDB.toDoTasks.removeAt(index);
      toDoDB.updateDB();
    });
  }

  Future<void> createNewTask() async {
    bool? result = await showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
            nameController: taskNameController,
            textController: taskTextController);
      },
    );
    if (result == null) {
      if (taskNameController.text.isNotEmpty) {
        setState(() {
          toDoDB.toDoTasks.add([
            taskNameController.text,
            taskTextController.text,
            false,
            DateFormat("HH:mm, dd-MM-yy").format(DateTime.now())
          ]);
        });
        toDoDB.updateDB();
      }
      clearField();
    }
  }

  void clearField() {
    taskTextController.clear();
    taskNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const RootDrawer(selectedIndex: 0,),
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const RootAppBar(label: "TO DOs"),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15, top: 15),
          child: ListView.builder(
              itemCount: toDoDB.toDoTasks.length,
              itemBuilder: (context, index) {
                return TodoElement(
                    taskName: toDoDB.toDoTasks[index][0],
                    taskText: toDoDB.toDoTasks[index][1],
                    taskCompleted: toDoDB.toDoTasks[index][2],
                    taskDate: toDoDB.toDoTasks[index][3],
                    deleteTodo: (context) => deleteTodo(index),
                    editTodo: () => editTodo(index),
                    completeTodo: (value) =>
                        itemChecked(value = value, index = index));
              }),
        ),
      ),
    );
  }
}
