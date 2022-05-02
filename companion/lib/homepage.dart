import 'package:companion/function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_task_screen.dart';
import 'task_tile.dart';
import 'task.dart';
import 'function.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  bool ischeck = false;

  void check(bool val) {
    val = !val;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 10, left: 30),
            child: CircleAvatar(
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.menu_rounded,
                    size: 30,
                    color: Colors.blue.withOpacity(0.8),
                  )),
              backgroundColor: Colors.white,
              radius: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: Text(
              "Your Task ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              "Maestro",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 30),
            child: Text(
              "${Provider.of<functions>(context).tasks.length.toString()} Tasks",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white),
              child: Task_List(),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => AddTaskScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Task_List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<functions>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemCount: taskData.tasks.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Text("Do you want to remove task ?"),
                          actions: [
                            TextButton(onPressed: () {

                              Provider.of<functions>(context,listen: false).deleteTask(index);
                              Navigator.pop(context);

                            }, child: Text("Yes")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("No")),
                          ],
                        ));
              },
              child: TaskTile(
                task: taskData.tasks[index].task,
                isdone: taskData.tasks[index].isdone,
                callback: (val) {
                  taskData.toggleTask(taskData.tasks[index]);
                },
              ),
            );
          },
        );
      },
    );
  }
}
