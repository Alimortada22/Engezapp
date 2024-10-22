import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:engez/component/add_new_task.dart';
import 'package:engez/component/task_tile.dart';
import 'package:engez/data/abstraction_database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage(this.db, {super.key});
  final LocalDatabase db;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //revernce to hive box
  final _box = Hive.box('mybox');
  TextEditingController textController = TextEditingController();
  final _confitteController = ConfettiController();
  bool isplaying = false;
  @override
  void dispose() {
    super.dispose();
    _confitteController.dispose();
    textController.dispose();
  }

  @override
  void initState() {
    super.initState();
    //create initial data if this is the 1st time ever open the app
    if (_box.get("TODOLIST") == null) {
      widget.db.createInitialData();
    } else {
        widget.db.loadData();
     
    }
  }

  //onchecked function to change status
  void onChanged(bool? ischecked, int index) {
    setState(() {
      widget.db.todo[index][1] = ischecked;
    });
    widget.db.updateData();
  }

// add new task

  void showdialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AddNewTask(
            newtaskcontroller: textController,
            onsave: addTask,
            oncancel: () {
              Navigator.pop(context);
            },
          );
        });
  }

//create newtask
  void addTask() {
    if (textController.text.isNotEmpty) {
      setState(() {
        widget.db.todo.add([textController.text, false]);
      });
    
        widget.db.updateData();
    
      textController.clear();
    }
  }

//remove specific task
  void removeTask(int index) {
    setState(() {
      widget.db.todo.removeAt(index);
    });
    try {
      widget.db.updateData();
    } on HiveError catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message), duration: const Duration(seconds: 2)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, children: [
      Scaffold(
        appBar: AppBar(
          title: const Text(
            "Engez",
            style: TextStyle(fontFamily: "Handlee-Regular", fontSize: 32),
          ),
          backgroundColor: Colors.blue,
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: Colors.blue[200],
        floatingActionButton: FloatingActionButton(
          onPressed: showdialog,
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.add,
          ),
        ),
        body: ListView.builder(
          itemCount: widget.db.todo.length,
          itemBuilder: (BuildContext context, index) {
            return TodoTile(
              taskName: widget.db.todo[index][0],
              ischecked: widget.db.todo[index][1],
              onChanged: (value) async {
                onChanged(value, index);
                if (value == true) {
                  _confitteController.play();
                  await Future.delayed(const Duration(seconds: 5));
                  _confitteController.stop();
                }
              },
              removetask: (context) {
                removeTask(index);
              },
            );
          },
        ),
      ),
      ConfettiWidget(
        confettiController: _confitteController,
        blastDirection: pi / 2,
        emissionFrequency: 0.5,
      ),
    ]);
  }
}
