import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:pedometer/01_Pages/01_04_FirstPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedometer/03_FireBase/03_01_TextDaialog.dart';
import 'package:pedometer/03_FireBase/03_02_WillPopScope.dart';
import 'package:pedometer/03_FireBase/03_04_SignupModel.dart';
import '01_01_SigninPage.dart';

class SignUpPage extends StatefulWidget {
  var mailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmController = TextEditingController();
  late String mail;
  late String password;
  late String confirm;

  SignUpPage.make() {}

  SignUpPage.modoru(this.mail, this.password, this.confirm) {
    this.mailController = TextEditingController(text: this.mail);
    this.passwordController = TextEditingController(text: this.password);
    this.confirmController = TextEditingController(text: this.confirm);
  }

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //ページ1より
  var mailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmController = TextEditingController();

  void initState() {
    mailController = widget.mailController;
    passwordController = widget.passwordController;
    confirmController = widget.confirmController;
  }

  bool _isCheck = false;

  void _handleCheckbox(bool isCheck) {
    setState(() {
      _isCheck = isCheck;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopCallback,
      child: ChangeNotifierProvider<SignUpModel>(
          create: (_) => SignUpModel()..init(),
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(40.0),
              child: AppBar(
                backgroundColor: Colors.green,
              ),
            ),
            body: Consumer<SignUpModel>(
              builder: (context, model, child) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Padding(padding: EdgeInsets.all(70)),
                        Column(
                          children: [
                            Center(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 120,
                                            child: Image.asset(
                                                'images/FriendsTree.png'),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        controller: mailController,
                                        onChanged: (text) {
                                          model.changeMail(text);
                                        },
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 16),
                                        decoration: InputDecoration(
                                          errorText: model.errorMail == ''
                                              ? null
                                              : model.errorMail,
                                          labelText: 'メールアドレス',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        controller: passwordController,
                                        onChanged: (text) {
                                          model.changePassword(text);
                                        },
                                        obscureText: true,
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 16),
                                        decoration: InputDecoration(
                                          errorText: model.errorPassword == ''
                                              ? null
                                              : model.errorPassword,
                                          labelText: 'パスワード',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        controller: confirmController,
                                        onChanged: (text) {
                                          model.changeConfirm(text);
                                        },
                                        obscureText: true,
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 16),
                                        decoration: InputDecoration(
                                          labelText: 'パスワード（確認用）',
                                          errorText: model.errorConfirm == ''
                                              ? null
                                              : model.errorConfirm,
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 24,
                                                child: Checkbox(
                                                  activeColor:
                                                      Color(0xFF4CAF50),
                                                  checkColor: Colors.white,
                                                  onChanged: (val) {
                                                    model.tapAgreeCheckBox(val);
                                                  },
                                                  value: model.agreeGuideline,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Flexible(
                                                child: RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: '利用規約',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF4CAF50),
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationThickness:
                                                              2.00,
                                                        ),
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = () {
                                                                _SignUprulesURL();
                                                              },
                                                      ),
                                                      TextSpan(
                                                          text: ' を読んで同意しました。'),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              FloatingActionButton.extended(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5), //角の丸み
                                                ),
                                                label: Text('新規登録'),
                                                backgroundColor:
                                                    const Color(0xFF4CAF50),
                                                onPressed: model.agreeGuideline
                                                    ? () async {
                                                        try {
                                                          await model.signUp();
                                                          await Navigator
                                                              .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      FirstPage(),
                                                            ),
                                                          );
                                                          model.endLoading();
                                                        } catch (e) {
                                                          showTextDialog(
                                                              context, e);
                                                          model.endLoading();
                                                        }
                                                      }
                                                    : null,
                                              ),
                                              FlatButton(
                                                child: Text(
                                                  'ログイン画面に戻る',
                                                ),
                                                textColor: Color(0xFF9E9E9E),
                                                onPressed: () {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SignInPage(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          )),
    );
  }
}

void _SignUprulesURL() async {
  const url =
      'https://dented-handball-204.notion.site/0fe2fc1cf0ca465abdb85616658c9106';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
