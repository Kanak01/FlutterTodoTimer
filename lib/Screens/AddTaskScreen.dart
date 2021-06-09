import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_second/models/TaskData.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late String taskTitle;
  Color _color = Colors.blueGrey;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Enter the Task',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: _color,
            ),
          ),
          TextField(
            textAlign: TextAlign.center,
            autofocus: true,
            onChanged: (val) {
              taskTitle = val;
            },
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (taskTitle.isNotEmpty) {
                Provider.of<TaskData>(context, listen: false)
                    .addTask(taskTitle);
                Navigator.pop(context);
              }
            },
            child: Text(
              'Add Task',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.deepPurple[900],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
