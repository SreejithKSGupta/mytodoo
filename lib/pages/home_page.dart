import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/database.dart';
import '../util/dialog_box.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();
  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(),
        floatingActionButton: fabbtn(),
        body: bodycontainer());
  }

  AppBar appbar() {
    return AppBar(
      centerTitle: true,
      title: const Text('TO DO',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )),
      elevation: 8,
    );
  }

  FloatingActionButton fabbtn() {
    return FloatingActionButton(
      onPressed: createNewTask,
      child: const Icon(Icons.add),
    );
  }

  Center bodycontainer() {
    double swidth = MediaQuery.of(context).size.width < 800
        ? MediaQuery.of(context).size.width * 0.9
        : 600;
    return Center(
      child: SizedBox(
        width: swidth,
        child: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) => maketodotile(index),
        ),
      ),
    );
  }

  ToDoTile maketodotile(int index) {
    return ToDoTile(
      taskName: db.toDoList[index][0],
      taskCompleted: db.toDoList[index][1],
      onChanged: (value) => checkBoxChanged(value, index),
      deleteFunction: (context) => deleteTask(index),
    );
  }
}
