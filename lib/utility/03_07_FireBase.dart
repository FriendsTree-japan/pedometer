import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Firebase_Auth;
import 'package:pedometer/common/01_pedmeter.dart';
import 'package:intl/intl.dart';

import 'health.dart';

class FirestoreMethod {
  static FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  static final pedmeterRef = _firestoreInstance.collection('PEDOMETER_TBL');
  static final Firebase_Auth.FirebaseAuth auth =
      Firebase_Auth.FirebaseAuth.instance;
  static String housing = "住まい";
  static int todaySteps = 0;
  static int sumSteps = 0;
  static double sumKm = 0;

  static Future<void> makePedmeter(String location) async {
    DateTime now = DateTime.now();
    DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    DateTime tomorrow = DateTime(now.year, now.month, now.day +1);
    String today = outputFormat.format(now);
    DateTime midnight = DateTime(now.year, now.month, now.day);

    await HelthInfo().fetchStepData(now,midnight);
    try {
      await pedmeterRef.doc(auth.currentUser!.uid).set({
        'USER_ID': auth.currentUser!.uid,
        'HOUSING': location,
        'TODAY_STEPS': HelthInfo.steps!.toInt(),
        'SUM_STEPS': HelthInfo.steps!.toInt(),
        'SUM_KM': sumKm,
        'ZEN_STEPS_DATE': today,
      });
    } catch (e) {
      print('ユーザー登録に失敗しました --- $e');
    }
  }

  static Future<Pedmeter> getPedmeter() async {
    DocumentSnapshot _PedmeterDoc =
        await pedmeterRef.doc('${auth.currentUser!.uid}').get();
    String zenStepDatewk = _PedmeterDoc.get('ZEN_STEPS_DATE');
    DateTime now = DateTime.now();
    DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
    DateTime midnight = DateTime(now.year, now.month, now.day);
    DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    String today = outputFormat.format(now);
     int plusSteps = 0;
     int zenSteps = 0;
     zenSteps = _PedmeterDoc.get('TODAY_STEPS');

    await HelthInfo().fetchStepData(now,midnight);

    try {
      housing = _PedmeterDoc.get('HOUSING');
      todaySteps = HelthInfo.steps!.toInt();
      int sumStepsWk = _PedmeterDoc.get('SUM_STEPS');

      if(today.compareTo(zenStepDatewk) == 1){
        plusSteps = todaySteps;
      }else{
        plusSteps = todaySteps - zenSteps;
      }
      sumSteps = sumStepsWk + plusSteps;
      sumKm = (sumSteps/1290 * 100).round()/100;

    } catch (e) {
      print('歩数取得に失敗しました --- $e');
    }
    try {
      await pedmeterRef.doc(auth.currentUser!.uid).set({
        'USER_ID': auth.currentUser!.uid,
        'HOUSING': housing,
        'TODAY_STEPS': todaySteps,
        'SUM_STEPS': sumSteps,
        'SUM_KM': sumKm,
        'ZEN_STEPS_DATE': today,
      });
    } catch (e) {
      print('ユーザー登録に失敗しました --- $e');
    }
    Pedmeter myPedmeter = Pedmeter(
        HOUSING: _PedmeterDoc.get('HOUSING'),
        TODAY_STEPS: _PedmeterDoc.get('TODAY_STEPS'),
        SUM_STEPS: _PedmeterDoc.get('SUM_STEPS'),
        SUM_KM: _PedmeterDoc.get('SUM_KM'),
      ZEN_STEPS_DATE: _PedmeterDoc.get('ZEN_STEPS_DATE'),
    );


    return myPedmeter;
  }

  static Stream<QuerySnapshot> pedmeterSnapshot() {
    return pedmeterRef
        .doc(auth.currentUser!.uid)
        .collection('PEDOMETER_TBL')
        .snapshots();
  }
}
