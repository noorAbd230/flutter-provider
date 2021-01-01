

import 'package:flutter/cupertino.dart';
import 'package:flutter_provider_db/db_helper.dart';

class Task extends ChangeNotifier{
  int id;
  String taskName;
  bool isComplete;
  List<Task> taskList = [];

  Task({this.id,this.taskName,this.isComplete});

  setValue(List<Task> tasks) {
    this.taskList = tasks;
  }
  //  setValues(int id,String taskName,bool isComplete){
  //   this.id = id;
  //   this.taskName = taskName;
  //   this.isComplete = isComplete;
  //   taskList.add(Task(id: id,taskName: taskName,isComplete: isComplete));
  //   notifyListeners();
  // }

  List<Task> getValue() {
    return this.taskList;
  }
  //
  // getTasksFromDB(List<Map> tasks, Function fun) {
  //    tasks.map((e) {
  //      e.forEach((key, value) {
  //        taskList.add(Task(
  //            taskName: value[DBHelper.taskNameColumnName],
  //            isComplete: value[DBHelper.taskIsCompleteColumnName] == 1 ? true : false
  //        ));
  //      });
  //      fun();
  //    });
  //
  //   return this.taskList;
  // }


  getTasksFromDB(Future<List<Map>> tasks, Function fun) {
    tasks.then((value) {
      value.forEach((element) {
        this.taskList.add(Task(
            taskName: element[DBHelper.taskNameColumnName],
            isComplete: element[DBHelper.taskIsCompleteColumnName] == 1 ? true : false
        ));
      });
      fun();
    });
    return this.taskList;
  }

  toJson(){

    return {
      DBHelper.taskIdColumnName : this.id,
      DBHelper.taskNameColumnName : this.taskName,
      DBHelper.taskIsCompleteColumnName:this.isComplete ? 1 : 0,

    };

  }

  insertTask(Task task) {
    this.taskList.add(task);
    notifyListeners();
  }

  deleteTask(Task task) {
    this.taskList.remove(task);
    notifyListeners();
  }

  updateTask(Task task) {
    this.taskList.forEach((element) {
      if (element.taskName == task.taskName)
      {
        element.isComplete = task.isComplete;
      }
    });
    notifyListeners();
  }
  fromJson(Map<String,dynamic> map){
    id = map[DBHelper.taskIdColumnName];
    taskName = map[DBHelper.taskNameColumnName];
    isComplete = map[DBHelper.taskIsCompleteColumnName]!=0;

  }
}