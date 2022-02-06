import 'dart:async';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:pedometer/utility/health.dart';
import '01_05_TodayPage.dart';
import '01_06_TotalPage.dart';

class FirstPage extends StatefulWidget {

  @override
  State<FirstPage> createState() => _FirstPage();
}


class _FirstPage extends State<FirstPage> {
  String activeLocation = 'お住い';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      home: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ようこそ' ,style: TextStyle(fontSize: 40),),
              Padding(padding:  EdgeInsets.all(SizeConfig.widgetPaddingSize * 2.5)),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_outlined),
                      TextButton(onPressed: (){
                        _showModalPicker(context);
                      }, child: Text(activeLocation ,style: TextStyle(fontSize: 22 ,color: Colors.black),),),
                    ],
                ),
              ),
              Padding(padding:  EdgeInsets.all(SizeConfig.widgetPaddingSize * 2.5)),
              ElevatedButton(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.green,
                        Colors.green,
                        Colors.green,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(50,10,50,10),
                  child: const Text('利用開始',style: TextStyle(fontSize: 20 ,color: Colors.white)),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                ),
                onPressed: () {
                  if (
                  activeLocation == 'お住い'
                  ){
                    AlertDialog(
                      title: Text('お住いを選択してください'),
                      actions: [
                        FlatButton(
                          child: Text("閉じる"),
                          onPressed: () => Navigator.pop(context),)
                      ],
                    );
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TotalPage()));
                }},
              ),
            ],
          )),
    );
  }
  void _showModalPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CupertinoPicker(
              itemExtent: 40,
              children: _Location.map(_pickerItem).toList(),
              onSelectedItemChanged: _onSelectedLocationChanged,
            ),
          ),
        );
      },
    );
  }

  final List<String> _Location = [
    "北海道",
    "青森県",
    "岩手県",
    "宮城県",
    "秋田県",
    "山形県",
    "福島県",
    "茨城県",
    "栃木県",
    "群馬県",
    "埼玉県",
    "千葉県",
    "東京都",
    "神奈川県",
    "新潟県",
    "富山県",
    "石川県",
    "福井県",
    "山梨県",
    "長野県",
    "岐阜県",
    "静岡県",
    "愛知県",
    "三重県",
    "滋賀県",
    "京都府",
    "大阪府",
    "兵庫県",
    "奈良県",
    "和歌山県",
    "鳥取県",
    "島根県",
    "岡山県",
    "広島県",
    "山口県",
    "徳島県",
    "香川県",
    "愛媛県",
    "高知県",
    "福岡県",
    "佐賀県",
    "長崎県",
    "熊本県",
    "大分県",
    "宮崎県",
    "鹿児島県",
    "沖縄県",
  ];

  Widget _pickerItem(String str) {
    return Text(
      str,
      style: const TextStyle(fontSize: 20),
    );
  }

  void _onSelectedLocationChanged(int index) {
    setState(() {
      activeLocation = _Location[index];
    });
  }
}

//端末サイズの調整
class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double widgetHeightSizeFirst;
  static late double widgetHeightSizeSecond;
  static late double widgetHeightSizeThird;
  static late double widgetHeightSizePhoto;
  static late double widgetPaddingSize;
  static late double bigFontSize;
  static late double middleFontSize;
  static late double smallFontSize;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    //デバイスのサイズを取得
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    //フォントのサイズを定義
    bigFontSize = 40.0;
    middleFontSize = 14.0;
    smallFontSize = 12.0;

    //各ウィジェッsアイズを定義
    if (screenHeight > 900) {
      widgetHeightSizeFirst = 280.0;
      widgetHeightSizeSecond = 140.0;
      widgetHeightSizeThird = 140.0;
      widgetHeightSizePhoto = 200;
    } else if (screenHeight > 700) {
      widgetHeightSizeFirst = 280.0;
      widgetHeightSizeSecond = 126.0;
      widgetHeightSizeThird = 150.0;
      widgetHeightSizePhoto = 200;
    } else {
      widgetHeightSizeFirst = 280.0;
      widgetHeightSizeSecond = 126.0;
      widgetHeightSizeThird = 120.0;
      widgetHeightSizePhoto = 180;
    }

    //各ウィジェット間のPaddingの値を定義
    if (screenHeight > 900) {
      widgetPaddingSize = 26.0;
    } else if (screenHeight > 700) {
      widgetPaddingSize = 20.0;
    } else {
      widgetPaddingSize = 5.0;
    }
  }
}