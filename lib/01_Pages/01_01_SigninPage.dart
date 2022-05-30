import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedometer/utility/03_07_FireBase.dart';
import 'package:pedometer/03_FireBase/03_01_TextDaialog.dart';
import 'package:pedometer/03_FireBase/03_02_WillPopScope.dart';
import 'package:pedometer/03_FireBase/03_03_SigninModel.dart';
import '01_02_SignupPage.dart';
import '01_03_PasswordForgetPage.dart';
import '01_04_FirstPage.dart';
import '01_05_TodayPage.dart';

class SignInPage extends StatelessWidget {
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopCallback,
      child: ChangeNotifierProvider<SignInModel>(
        create: (_) => SignInModel(),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: AppBar(
                backgroundColor: Colors.green),
          ),
          body: Consumer<SignInModel>(
            builder: (context, model, child) {
              return Stack(
                children: [
                  Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child:
                                  Image.asset('images/FriendsTree.jpg'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            TextFormField(
                              controller: mailController,
                              onChanged: (text) {
                                model.changeMail(text);
                              },
                              maxLines: 1,
                              decoration: InputDecoration(
                                errorText: model.errorMail == ''
                                    ? null
                                    : model.errorMail,
                                labelText: 'メールアドレス',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: passwordController,
                              onChanged: (text) {
                                model.changePassword(text);
                              },
                              obscureText: true,
                              maxLines: 1,
                              decoration: InputDecoration(
                                errorText: model.errorPassword == ''
                                    ? null
                                    : model.errorPassword,
                                labelText: 'パスワード',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: RaisedButton(
                                child: Text('ログイン'),
                                color: Color(0xFF4CAF50),
                                textColor: Colors.white,
                                onPressed: model.isMailValid &&
                                    model.isPasswordValid
                                    ? () async {
                                  model.startLoading();
                                  try {
                                    await model.login();
                                    await FirestoreMethod.getPresentValue();
                                    await FirestoreMethod.getPedometer_manage();
                                    //ダウンロードテスト
                                    // await FirestoreMethod().downloadImage();
                                    await Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TodayPage(),
                                      ),
                                    );
                                  } catch (e) {
                                    showTextDialog(context, e.toString());
                                    model.endLoading();
                                  }
                                }
                                    : null,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            FlatButton(
                              child: Text(
                                '新規登録はこちら',
                              ),
                              textColor: Color(0xFF4CAF50),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpPage.make(),
                                  ),
                                );
                              },
                            ),
                            FlatButton(
                              child: Text(
                                'パスワードを忘れた場合',
                              ),
                              textColor: Colors.grey,
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgetPasswordPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  model.isLoading
                      ? Container(
                    color: Colors.black.withOpacity(0.3),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                      : SizedBox(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}