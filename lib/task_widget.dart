import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_db/db_helper.dart';
import 'package:flutter_provider_db/task_model.dart';
import 'package:provider/provider.dart';


class TaskWidget extends StatefulWidget {
  Task list;
  Function function;

  TaskWidget({
    this.list,this.function
  });

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  int count=0;

  @override
  Widget build(BuildContext context) {
    return Container(
        child:
        Card(
          color: Colors.grey[100],
          margin: EdgeInsets.all(10),
          child:
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (param) {
                        return AlertDialog(
                          title: Text('Alert'),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          content: Text(
                              'You Will Delete A task, are you sure?'),
                          actions: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: GestureDetector(
                                child: Text('OK', style: TextStyle(
                                    color: Colors.blueAccent),),
                                onTap: () {
                                  Provider.of<Task>(context, listen: false).deleteTask(widget.list);
                                  setState(() {});
                                  widget.function();
                                  Navigator.pop(context);

                                },
                              ),
                            ),
                            SizedBox(width: 10,),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: GestureDetector(
                                child: Text('NO', style: TextStyle(
                                    color: Colors.blueAccent),),
                                onTap: () {
                                  Navigator.pop(context);
                                },

                              ),
                            ),
                          ],
                        );
                      }
                  );
                },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),

                ),
                Text(widget.list.taskName),
                Checkbox(value: widget.list.isComplete,
                  onChanged: (val) {
                    widget.list.isComplete =
                    !widget.list.isComplete;
                    Provider.of<Task>(context, listen: false).updateTask(widget.list);
                    setState(() {
                    });
                    widget.function();

                    // if(widget.list.length!=0){

                    // }

                  },
                )
              ],
            ),
          ),


        )


    );
  }
}


