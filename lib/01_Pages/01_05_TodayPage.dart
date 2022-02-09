import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pedometer/utility/health.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '99_bk.dart';
import '01_06_TotalPage.dart';

class TodayPage extends StatefulWidget {
  @override
  State<TodayPage> createState() => _TodayPage();
}

class _TodayPage extends State<TodayPage> {
  int remainingDays = 1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.navigate_next_outlined),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TotalPage()));
                },
              ),
            ],
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                Container(
                  height: 60.0,
                  child: DrawerHeader(
                    child: Text("メニュー"),
                    decoration: BoxDecoration(),
                  ),
                ),
                ListTile(
                  title: Text('問い合わせ',
                      style: TextStyle(
                      )),
                  onTap: _FAQURL,
                ),
                ListTile(
                  title: Text('利用規約',
                      style: TextStyle(
                      )),
                  onTap: _rulesURL,
                ),
                ListTile(
                  title: Text('ソフトウェアライセンス',
                      style: TextStyle(
                      )),
                  onTap: () => showLicensePage(
                    context: context,
                    applicationName: '万歩計アプリ',
                    applicationVersion: '1.0.0',
                  ),
                )
              ],
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.green,
                      width: 10
                  ),
                ),
                child: Image.asset("images/MtFuji.jpg"),
              ),
              Padding(padding: EdgeInsets.all(20)),
              Card(
                margin: const EdgeInsets.all(10.0),
                //color: Colors.green,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  width: 300,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text('本日の合計歩数',
                          style: TextStyle(fontSize: 16,color: Colors.black),),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(HelthInfo.steps.toString(),
                                style: TextStyle(fontSize: 28,color: Colors.green),),
                            ),
                            Container(
                              child: Text('歩',
                                style: TextStyle(fontSize: 12,color: Colors.green),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(10.0),
                //color: Colors.green,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  width: 300,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text('東京制覇まであと',
                          style: TextStyle(fontSize: 16,color: Colors.black),),
                      ),
                      Stack(
                        children: [
                              SizedBox(
                                  child: LinearProgressIndicator(
                                    minHeight: 30.0,
                                    backgroundColor: Colors.black12,
                                    value: 0.2,
                                  )),
                        ],
                      ),
                      Container(
                        child: Text('5/47都道府県制覇中',
                          style: TextStyle(fontSize: 16,color: Colors.black),),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),),
    );
  }
}

void _manualURL(String getUrl) async {
  print(getUrl);
  String url = getUrl;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _FAQURL() async {
  const url =
      'https://dented-handball-204.notion.site/9fbc188c11d14c9d95fb2c959fa33043';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _rulesURL() async {
  const url =
      'https://dented-handball-204.notion.site/0fe2fc1cf0ca465abdb85616658c9106';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}