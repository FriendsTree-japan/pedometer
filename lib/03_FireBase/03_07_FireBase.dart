import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Firebase_Auth;

class FirestoreMethod {
  static FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  static final userKeyWordRef = _firestoreInstance.collection(
      'UserKeyWord');
  static final Firebase_Auth.FirebaseAuth auth =
      Firebase_Auth.FirebaseAuth.instance;
  static String getCheck = "0";
  static late String getPlayKeyWord1;
  static late String getPlayKeyWord2;
  static late String getPlayKeyWord3;
  static late String getWorkKeyWord1;
  static late String getWorkKeyWord2;
  static late String getWorkKeyWord3;

  static Future<void> addKeyword(String playKeyWord1,String playKeyWord2,String playKeyWord3,String workKeyWord1,String workKeyWord2,workKeyWord3) async {
    try {
      await userKeyWordRef.doc(auth.currentUser!.uid).set({
        'USER_ID': auth.currentUser!.uid,
        'playKeyWord1':playKeyWord1,
        'playKeyWord2':playKeyWord2,
        'playKeyWord3':playKeyWord3,
        'wordKeyWord1':workKeyWord1,
        'wordKeyWord2':workKeyWord2,
        'wordKeyWord3':workKeyWord3,
      });
      getPlayKeyWord1 = playKeyWord1;
      getPlayKeyWord2 = playKeyWord2;
      getPlayKeyWord3 = playKeyWord3;
      getWorkKeyWord1 = workKeyWord1;
      getWorkKeyWord2 = workKeyWord2;
      getWorkKeyWord3 = workKeyWord3;

      getCheck ="1";
    }
    catch (e) {
      print('キーワード登録に失敗しました --- $e');
    }
  }

  static Future<void> getKeyword(String userId) async {
    try {
      DocumentSnapshot _KeyWordDoc = await userKeyWordRef
          .doc('${auth.currentUser!.uid}')
          .get();
      getPlayKeyWord1 = _KeyWordDoc.get('playKeyWord1');
      getPlayKeyWord2 = _KeyWordDoc.get('playKeyWord2');
      getPlayKeyWord3 = _KeyWordDoc.get('playKeyWord3');
      getWorkKeyWord1 = _KeyWordDoc.get('wordKeyWord1');
      getWorkKeyWord2 = _KeyWordDoc.get('wordKeyWord2');
      getWorkKeyWord3 = _KeyWordDoc.get('wordKeyWord3');
      getCheck ="1";
    }
    catch (e) {
      print('キーワード取得に失敗しました --- $e');
      getCheck ="0";
    }
  }


}