import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simple_timer/simple_timer.dart';

class TimerApp extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<TimerApp> with SingleTickerProviderStateMixin {
  late TimerController _timerController;

  @override
  void initState() {
    _timerController = TimerController(this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade700,
          title: Text(
            "Pomodoro Timer 🕓",
            style: TextStyle(
              fontSize: 36.0,
              color: Colors.white70,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey,
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(80.0),
                child: Expanded(
                  child: SimpleTimer(
                    duration: const Duration(minutes: 25),
                    controller: _timerController,
                    timerStyle: TimerStyle.ring,
                    backgroundColor: Colors.white30,
                    progressIndicatorColor: Colors.white,
                    progressTextStyle: TextStyle(
                        color: Colors.white, fontSize: 25.0),
                    strokeWidth: 18.0,
                  ),
                ),
              ),
              
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 30.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Study 25 minutes.",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 22.0,

                          ),
                        ),
                        Text(
                          "Break for 5 minutes.",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 22.0,
                          ),
                        ),
                        Text(
                          "Break of 30 minutes after 4 cycles.",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 22.0,
                          ),
                        ),
                        SizedBox(height: 40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextButton(
                              onPressed: _timerController.start,
                              child: const Text(
                                "Start",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blueGrey.shade700,
                              ),
                            ),
                            TextButton(
                              onPressed: _timerController.pause,
                              child: const Text(
                                "Pause",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blueGrey.shade700,
                              ),
                            ),
                            TextButton(
                              onPressed: _timerController.reset,
                              child: const Text(
                                "Reset",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blueGrey.shade700,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
