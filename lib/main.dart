import 'package:flutter/material.dart';
import 'package:flutter_provider_db/db_helper.dart';
import 'package:flutter_provider_db/new_task.dart';
import 'package:flutter_provider_db/task_model.dart';
import 'package:flutter_provider_db/task_widget.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return Task();
      },
      child: MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

TabController tabController;
class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}
List<Task> list = List<Task>();
class _TodoAppState extends State<TodoApp> with SingleTickerProviderStateMixin{



  getAllTask() async{
    list = List<Task>();
    var taskList = await DBHelper.dbHelper.selectAllTask();

    taskList.forEach((element) {

      //list.add(context.read<Task>().setValues(element[DBHelper.taskIdColumnName],element[DBHelper.taskNameColumnName], element[DBHelper.taskIsCompleteColumnName]!=0));

    });
  }
  @override
  void initState() {
    super.initState();
    tabController=TabController(length: 3,vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text('Todo'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            controller: tabController,
            tabs: [
              Tab(text: 'All Tasks',),
              Tab(text: 'Complete Tasks',),
              Tab(text: 'Incomplete Tasks',),
            ],isScrollable: true,),
        ),
        drawer: Drawer(),

        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                // physics: NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  AllTasks(list: list,function: (){
                    getAllTask();
                  },),
                  CompleteTasks(),
                  IncompleteTasks()
                ],
              ),
            ),

          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add,color: Colors.white,),
          backgroundColor: Colors.blueAccent,
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context){
              return NewTask(getAllTask);
            }));
          },
        ),

      );
  }
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Consumer<Task>(
          builder: (context, value, child) {
            var tasks = value.getTasksFromDB(DBHelper.dbHelper.selectAllTask(), mFun);
            value.setValue(tasks);
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => TodoApp(),
              ));
            });
            return Container();
          },
        )
    );
  }
  void mFun() {
    setState(() {});
  }
}

class AllTasks extends StatefulWidget {
  Function function;
  final List<Task> list;
  AllTasks({this.function,this.list});
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {

  void fun(){
    setState(() {});
  }
  @override
  Widget build(BuildContext context)  {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: Provider.of<Task>(context, listen: false).getValue().length,
        itemBuilder: (context, index){
          Task task = Provider.of<Task>(context, listen: false).getValue()[index];
          if(task.taskName!=null)  {
            return TaskWidget(list: task,function: fun,);
          }else{
            return Center(child:Text('No Tasks Added Yet'));
          }

        },
      ),
    );
  }
}

class CompleteTasks extends StatefulWidget {
  @override
  _CompleteTasksState createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {

  //List<Task> list = List<Task>();
  getCompleteTask() async{
    // list = List<Task>();
    //  var taskList = await DBHelper.dbHelper.selectCompleteTask();
    //
    //  taskList.forEach((element) {
    //   list.where((element) => element.isComplete==true).map((e) => TaskWidget()).toList(),
    //  });

  }
  void fun(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: Provider.of<Task>(context, listen: false).getValue().length,
        itemBuilder: (context, index){
          Task task = Provider.of<Task>(context, listen: false).getValue()[index];
          if(task.isComplete){
            return TaskWidget(list: task,function: fun,);
          }else{
            return Container();
          }
        },
      ),
    );
  }
}
class IncompleteTasks extends StatefulWidget {
  @override
  _IncompleteTasksState createState() => _IncompleteTasksState();
}

class _IncompleteTasksState extends State<IncompleteTasks> {
  //
  // List<Task> list = List<Task>();
  // getInCompleteTask() async{
  //   list = List<Task>();
  //   var taskList = await DBHelper.dbHelper.selectIncompleteTask();
  //
  //   taskList.forEach((element) {
  //     list.add(context.read<Task>().setValues(element[DBHelper.taskIdColumnName],element[DBHelper.taskNameColumnName], element[DBHelper.taskIsCompleteColumnName]!=0));
  //
  //   });
  // }
  void fun(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: Provider.of<Task>(context, listen: false).getValue().length,
        itemBuilder: (context, index){
          Task task = Provider.of<Task>(context, listen: false).getValue()[index];
          if(!task.isComplete){
            return TaskWidget(list: task,function: fun,);
          }else{
            return  Container();
          }
        },
      ),
    );
  }
}