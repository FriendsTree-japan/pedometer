import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:pedometer/utility/health.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '01_05_TodayPage.dart';
import 'package:pedometer/99_Others/99_Adomob.dart';

class TotalPage extends StatefulWidget {
  @override
  State<TotalPage> createState() => _TotalPage();
}

class _TotalPage extends State<TotalPage> {
  String dropdownvalue = '日本一周（約1万2000キロ）';//dropdownvalue変数にItem1をセットする

  // 変数itemsに配列をセットする
  var items = [
    '日本一周（約1万2000キロ）',
    '地球の半径（約6000キロ）',
    '東京大阪間の往復（約1,000キロ）',
    '琵琶湖1周（約200キロ）',
    '24時間マラソン（約100キロ）',
    '山手線1周（約35キロ）',
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TodayPage()));
              },
            ),
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on_outlined,size: 18,),
                  Padding(padding: EdgeInsets.all(5)),
                  DropdownButton(
                    value: dropdownvalue,
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ],
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.directions_walk,size: 40,),
                              Container(
                                child: Column(
                                  children: [
                                    Text('合計歩数',style: TextStyle(fontSize: 20),),
                                    Text('アプリを初めてこれまでに歩いた合計歩数',
                                      style: TextStyle(fontSize: 12,color: Colors.black12),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text('15,476,881',
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.directions_walk,size: 40,),
                            Container(
                              child: Column(
                                children: [
                                  Text('合計距離',style: TextStyle(fontSize: 20),),
                                  Text('アプリを初めてこれまでに歩いた合計距離',
                                    style: TextStyle(fontSize: 12,color: Colors.black12),)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text('12,000.0',
                                style: TextStyle(fontSize: 28,color: Colors.green),),
                            ),
                            Container(
                              child: Text('Km',
                                style: TextStyle(fontSize: 12,color: Colors.green),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AdBanner(size: AdSize.banner),
              ),
            ],
          )),
    );
  }
}
