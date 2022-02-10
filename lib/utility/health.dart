import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:health/health.dart';


class HelthInfo {
  List<HealthDataPoint> _healthDataList = [];
  HealthFactory health = HealthFactory();
  static int? steps = 0;
  static int? plusSteps = 0;
  static String? meter;
  // define the types to get
  var types = [
    HealthDataType.STEPS,
    HealthDataType.WEIGHT,
    HealthDataType.HEIGHT,
    HealthDataType.BLOOD_GLUCOSE,
    HealthDataType.DISTANCE_WALKING_RUNNING
  ];


  /// Fetch steps from the health plugin and show them in the app.
  Future fetchStepData(DateTime zenStepDate,DateTime now,DateTime midnight) async {
    // get steps for today (i.e., since midnight)

    bool requested = await health.requestAuthorization([HealthDataType.STEPS]);

    if (requested) {
      try {
        steps = await health.getTotalStepsInInterval(midnight, now);
        print(steps);
        plusSteps = await health.getTotalStepsInInterval(zenStepDate, now) ?? 0;
      } catch (error) {
        print("Caught exception in getTotalStepsInInterval: $error");
      }

      print('Total number of steps: $steps');

    } else {
      print("Authorization not granted");
    }
  }
}