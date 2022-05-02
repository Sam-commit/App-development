
class Task{

  String task;
  bool isdone;

  Task({ required this.isdone,required this.task});

  void toggle(){
    isdone = !isdone;
  }

}