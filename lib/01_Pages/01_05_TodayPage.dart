import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:pedometer/utility/health.dart';

class TodayPage extends StatefulWidget {

  @override
  State<TodayPage> createState() => _TodayPage();
}


class _TodayPage extends State<TodayPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Health Example'),
          ),
          body: Center(
              child: Text(HelthInfo.steps.toString())
          )),
    );
  }
}