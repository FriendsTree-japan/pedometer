import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:pedometer/utility/03_07_FireBase.dart';
import 'package:pedometer/utility/03_otherMethod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pedometer/utility/health.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '99_bk.dart';
import '01_06_TotalPage.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TodayPage extends StatefulWidget {
  @override
  State<TodayPage> createState() => _TodayPage();
}

class _TodayPage extends State<TodayPage> {
  int remainingDays = 1;
  CarouselController _carouselController = CarouselController();

  // late String PresentValue;
  // late String NextPresentValue ="";
  // @override
  // void initState() {
  //   PresentValue = OtherMethod().todofukenHenkanMethod(FirestoreMethod.PresentV);
  //   NextPresentValue = OtherMethod().todofukenHenkanMethod(FirestoreMethod.PrezentVnextPrefectures);
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              '歩いて日本を1周しよう',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.account_circle_outlined),
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
                  title: Text('問い合わせ', style: TextStyle()),
                  onTap: _FAQURL,
                ),
                ListTile(
                  title: Text('利用規約', style: TextStyle()),
                  onTap: _rulesURL,
                ),
                ListTile(
                  title: Text('ソフトウェアライセンス', style: TextStyle()),
                  onTap: () => showLicensePage(
                    context: context,
                    applicationName: '万歩計アプリ',
                    applicationVersion: '1.0.0',
                  ),
                )
              ],
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
              stream: FirestoreMethod.pedmeterSnapshot(),
              builder: (context, snapshot) {
                return FutureBuilder<Object>(
                    future: FirestoreMethod.getPedmeter(),
                    builder: (context, snapshot) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFFE5E5E3),
                                        width: 10),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        color: const Color(0xFFE5E5E3),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text('現在地：'),
                                            Text(FirestoreMethod.PresentValue),
                                          ],
                                        ),
                                      ),
                                      CarouselSlider(
                                        options: CarouselOptions(
                                          autoPlay: true,
                                          viewportFraction: 1.0,
                                          autoPlayAnimationDuration: const Duration(seconds: 1)
                                        ),
                                        items:
                                            FirestoreMethod.imageUrls.map((i) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Image.network(
                                                i,
                                                fit: BoxFit.cover,
                                                width: 350,
                                                height: 200,
                                              );
                                            },
                                          );
                                        }).toList(),
                                      )
                                      // child: CarouselSlider(
                                      //   items: [ Container(
                                      //       child:
                                      //       Image.network(
                                      //         FirestoreMethod.imageUrls[0],
                                      //         fit: BoxFit.cover,
                                      //         width: 300,
                                      //         height: 200,)),
                                      //     Container(
                                      //         child:
                                      //         Image.network(
                                      //           FirestoreMethod.imageUrls[1],
                                      //           fit: BoxFit.cover,
                                      //           width: 300,
                                      //           height: 200,)),
                                      //     Container(
                                      //         child:
                                      //         Image.network(
                                      //           FirestoreMethod.imageUrls[2],
                                      //           fit: BoxFit.cover,
                                      //           width: 300,
                                      //           height: 200,)),
                                      //   ],
                                      //   carouselController: _carouselController,
                                      //   options: CarouselOptions(
                                      //     enlargeCenterPage:true,
                                      //     autoPlay: true,
                                      //   ),
                                      // ),

                                      // Container(
                                      //     child:
                                      //             Image.network(FirestoreMethod.imageUrls[0], fit: BoxFit.cover, width: 300,height: 200,)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.all(5),
                            color: const Color(0xFFE5E5E3),
                            //color: Colors.green,
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              width: 350,
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      '${FirestoreMethod.PresentValue}制覇まであと',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      SizedBox(
                                          child: LinearProgressIndicator(
                                        minHeight: 40.0,
                                        color: Colors.black,
                                        backgroundColor: Colors.white,
                                        value: FirestoreMethod.ProgressRate,
                                      )),
                                    ],
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Next>',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          FirestoreMethod.NextPresentValue,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10)),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        color: const Color(0xFFFFE1FF),
                                        width: 170,
                                        height: 90,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Text(
                                                '合計歩数',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      FirestoreMethod.sumSteps
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.pink),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      '歩',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.pink),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 10, 10, 10)),
                                      Container(
                                        color: const Color(0xFFE9FFE1),
                                        width: 170,
                                        height: 90,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Text(
                                                '合計距離',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      FirestoreMethod.sumKm
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.green),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      'Km',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.green),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5)),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        color: const Color(0xFEFFF3E1),
                                        width: 170,
                                        height: 90,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Text(
                                                '本日の歩数',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      FirestoreMethod.todaySteps
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.orange),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      '歩',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.orange),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 10, 10, 10)),
                                      Container(
                                        color: const Color(0xFFE1ECFF),
                                        width: 170,
                                        height: 90,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Text(
                                                '本日の距離',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      FirestoreMethod.todayKm
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      'Km',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(20)),
                        ],
                      );
                    });
              })),
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
