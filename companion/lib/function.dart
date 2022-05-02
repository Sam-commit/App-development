import 'package:flutter/cupertino.dart';

import 'task.dart';

class functions extends ChangeNotifier {
  List<Task> tasks = [];

  void addTask(String task) {
    tasks.add(Task(isdone: false, task: task));
    notifyListeners();
  }

  void toggleTask(Task task){
    task.toggle();
    notifyListeners();
  }

  void deleteTask(int index){

    tasks.removeAt(index);
    notifyListeners();

  }
}
