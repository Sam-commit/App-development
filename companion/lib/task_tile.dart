import 'package:flutter/material.dart';
import 'task.dart';

class TaskTile extends StatelessWidget {

  TaskTile({required this.task,required this.isdone,required this.callback});

  String task;
  bool isdone;
  Function callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        title: Text(task,style: TextStyle(decoration:isdone ? TextDecoration.lineThrough : null),),
        trailing: Checkbox(
          value: isdone,
          onChanged:(val){
            callback(val);
          },
        ),
      ),
    );
  }
}
