import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:health/health.dart';


class HelthInfo {
  List<HealthDataPoint> _healthDataList = [];
  HealthFactory health = HealthFactory();
  static int? steps = 0;
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
  Future fetchStepData() async {
    // get steps for today (i.e., since midnight)
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    bool requested = await health.requestAuthorization([HealthDataType.STEPS]);

    if (requested) {
      try {
        steps = await health.getTotalStepsInInterval(midnight, now);
      } catch (error) {
        print("Caught exception in getTotalStepsInInterval: $error");
      }

      print('Total number of steps: $steps');

    } else {
      print("Authorization not granted");
    }
  }

  Future fetchMeterData() async {
    // get steps for today (i.e., since midnight)
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    bool requested = await health.requestAuthorization([HealthDataType.DISTANCE_WALKING_RUNNING]);

    if (requested) {
      try {
        meter = (await health.getHealthDataFromTypes(midnight,now,types)) as String?;
      } catch (error) {
        print("Caught exception in getTotalStepsInInterval: $error");
      }
      print('Total number of steps: $steps');

    } else {
      print("Authorization not granted");
    }
  }
}