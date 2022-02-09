import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Firebase_Auth;
import 'package:pedometer/common/01_pedmeter.dart';

import 'health.dart';

class FirestoreMethod {
  static FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  static final pedmeterRef = _firestoreInstance.collection(
      'PEDOMETER_TBL');
  static final Firebase_Auth.FirebaseAuth auth =
      Firebase_Auth.FirebaseAuth.instance;
  static  String housing = "住まい";
  static  int todaySteps = 0;
  static  int sumSteps = 0;
  static  int sumKm = 0;

  static Future<void> makePedmeter(String location) async {
    try {
      await pedmeterRef.doc(auth.currentUser!.uid).set({
        'USER_ID': auth.currentUser!.uid,
        'HOUSING': location,
        'TODAY_STEPS':todaySteps,
        'SUM_STEPS':sumSteps,
        'SUM_KM':sumKm,
      });
    }
    catch (e) {
      print('ユーザー登録に失敗しました --- $e');
    }
  }

  static Future<Pedmeter> getPedmeter() async {
    await HelthInfo().fetchStepData();
    DocumentSnapshot _PedmeterDoc = await pedmeterRef
        .doc('${auth.currentUser!.uid}')
        .get();
    try {
      housing = _PedmeterDoc.get('HOUSING');
      todaySteps = HelthInfo.steps!.toInt();
      int sumStepsWk = _PedmeterDoc.get('SUM_STEPS');
      sumSteps = sumStepsWk + HelthInfo.steps!.toInt();
      sumKm = _PedmeterDoc.get('SUM_KM');
    }
    catch (e) {
      print('歩数取得に失敗しました --- $e');
    }
    try {
      await pedmeterRef.doc(auth.currentUser!.uid).set({
        'USER_ID': auth.currentUser!.uid,
        'HOUSING': housing,
        'TODAY_STEPS':todaySteps,
        'SUM_STEPS':sumSteps,
        'SUM_KM':sumKm,
      });
    }
    catch (e) {
      print('ユーザー登録に失敗しました --- $e');
    }
    Pedmeter myPedmeter = Pedmeter(
      HOUSING: _PedmeterDoc.get('HOUSING'),
      TODAY_STEPS:_PedmeterDoc.get('TODAY_STEPS'),
      SUM_STEPS:_PedmeterDoc.get('SUM_STEPS'),
      SUM_KM:_PedmeterDoc.get('SUM_KM')
    );

    return myPedmeter;
  }
  static Stream<QuerySnapshot> pedmeterSnapshot() {
    return pedmeterRef.doc(auth.currentUser!.uid).collection('PEDOMETER_TBL').snapshots();
  }


}