import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_db/db_helper.dart';
import 'package:flutter_provider_db/task_model.dart';
import 'package:provider/provider.dart';



class NewTask extends StatefulWidget {
  Function function;

  NewTask(this.function);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  bool isComplete=false;

  String taskName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(border:OutlineInputBorder(borderRadius: BorderRadius.circular(20)),),
                onChanged: (val){
                  taskName = val;
                },
              ),
              Checkbox(value: isComplete ,onChanged: (val){
                this.isComplete = !this.isComplete;

                setState(() {});
              },),
              RaisedButton(onPressed: (){
                // taskList.add(Task(taskName,isComplete));

                Provider.of<Task>(context, listen: false).insertTask(Task(taskName:this.taskName, isComplete:this.isComplete));
                Navigator.pop(context);


              },
                child: Text('Add New Task'),)
            ],
          )

      ),
    );
  }
}
