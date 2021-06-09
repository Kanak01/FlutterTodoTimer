import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_second/Screens/AddTaskScreen.dart';
import 'package:todoey_second/Screens/timer_screen.dart';
import 'package:todoey_second/models/Task.dart';
import 'package:todoey_second/models/TaskData.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color _color = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color,
      floatingActionButton: FloatingActionButton(
        backgroundColor: _color,
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTaskScreen(),
              ),
            ),
          );
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Icon(
                        Icons.list_alt_outlined,
                        size: 40,
                        color: _color,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TimerApp()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blueGrey),
                        
                      ),
                      child: Text(
                        "Timer 🕓",
                        style: TextStyle(
                          fontSize:18.0, 
                          fontWeight: FontWeight.bold,
                         color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Todoey',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.w700,
                    shadows: [
                      Shadow(
                        blurRadius: 7.0,
                        color: Colors.white,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${Provider.of<TaskData>(context).tasks.length} Task',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Consumer<TaskData>(
                builder: (context, taskData, child) {
                  return ReorderableListView(
                    children: taskData.tasks
                        .map(
                          (task) => Container(
                            key: Key('${taskData.tasks.indexOf(task)}'),
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: _color, width: 1),
                            ),
                            child: ListTile(
                              leading: Checkbox(
                                activeColor: _color,
                                value: task.isDone,
                                onChanged: (checkbox) {
                                  taskData.updateTask(task);
                                },
                              ),
                              title: Text(
                                task.name,
                                style: TextStyle(
                                  decoration: task.isDone
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  taskData.deleteTask(task);
                                },
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onReorder: (start, current) {
                      // drag from top to bottom
                      if (start < current) {
                        int end = current - 1;
                        Task startTask = taskData.tasks[start];
                        int i = 0;
                        int local = start;
                        do {
                          taskData.tasks[local] = taskData.tasks[++local];
                          i++;
                        } while (i < end - start);
                        taskData.tasks[end] = startTask;
                      }
                      // drag from bottom to top
                      if (start > current) {
                        Task startTask = taskData.tasks[start];
                        for (int i = start; i > current; i--) {
                          taskData.tasks[i] = taskData.tasks[i - 1];
                        }
                        taskData.tasks[current] = startTask;
                      }
                      setState(() {});
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
