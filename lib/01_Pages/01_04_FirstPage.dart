import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:pedometer/utility/health.dart';

class FirstPage extends StatefulWidget {

  @override
  State<FirstPage> createState() => _FirstPage();
}


class _FirstPage extends State<FirstPage> {

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