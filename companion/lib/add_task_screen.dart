import 'package:companion/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'function.dart';
import 'homepage.dart';

class AddTaskScreen extends StatelessWidget {

  String task="";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF757575),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                "Add Task",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                onChanged: (val){
                  task=val;
                },
                decoration: InputDecoration(
                  focusColor: Colors.blue,
                ),
                autofocus: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {

                        Provider.of<functions>(context,listen: false).addTask(task);
                        Navigator.pop(context);

                      },
                      child: Text(
                        "Add",
                        style: TextStyle(fontSize: 20),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
