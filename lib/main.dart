import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_second/Screens/HomeScreen.dart';
import 'package:todoey_second/models/TaskData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskData>(
      create: (context) => TaskData(),
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
