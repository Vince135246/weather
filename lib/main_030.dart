import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  runApp(ProviderScope(child: MyApp()));
}

var stateProvider = StateProvider<String>((ref) => "");

class MyApp extends ConsumerWidget {
  final TextEditingController myController = new TextEditingController();
  String strDataShow = "";
  int i = 0;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.lightGreen,
          ),
          flex: 1,
        ),
        Expanded(
          child: Flex(direction: Axis.horizontal, children: [
            Expanded(
              child: Container(
                color: Colors.white38,
                padding: EdgeInsets.all(10),
                child: TextField(
                    controller: myController,
                    decoration: InputDecoration(hintText: '請輸入城市名稱')),
              ),
              flex: 8,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Text('確認'),
                  onPressed: () async {
                    Dio dio = Dio();
                    Response response = await dio.get(
                        'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWA-8A1F00F6-428C-4537-B94B-AD8DCC99711B');
                    print(response.data);

                    var etSearch = myController.text;
                    List<dynamic> city =
                        response.data['records']['location']; //3
                    int k = 0;
                    strDataShow = "";
                    var strTempDataShow = "";

                    for (k = 0; k < city.length; k++) {
                      bool bMatch = city[k]['locationName'].contains(etSearch);
                      if ("" == etSearch) {
                      } else if (false == bMatch) {
                        continue;
                      }
                      strTempDataShow += city[k]['locationName'] + "\n";
                      int z = 0;
                      for (z = 0; z < 3; z++) {
                        var report = city[k]['weatherElement'][0]['time'][z];
                        strTempDataShow +=
                            report['startTime'].toString() + " ~ \n";
                        strTempDataShow += report['endTime'].toString() + "\n";
                        strTempDataShow +=
                            report['parameter']['parameterName'].toString() +
                                "\n";
                      }
                      strTempDataShow += "\n";
                    }
                    strTempDataShow += "\n";
                    strDataShow = strTempDataShow;
                    stateProvider = strDataShow as StateProvider<String>;
                    i = 1;

                    ref.watch(stateProvider);
                    //setState(() {});
                  },
                ),
              ),
              flex: 2,
            ),
          ]),
          flex: 2,
        ),
        Expanded(
          child: Flex(direction: Axis.horizontal, children: [
            Expanded(
              child: Container(
                color: Colors.white38,
                padding: EdgeInsets.all(10),
              ),
              flex: 1,
            ),
            Expanded(
              flex: 20,
              child: Container(
                  child: ListView(children: <Widget>[
                if (1 == i) Text("${strDataShow}"),
              ])),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.white38,
              ),
              flex: 1,
            )
          ]),
          flex: 18,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.lightGreen,
            height: 200,
          ),
          flex: 1,
        )
      ],
    );
  }
}

// class HomePage extends StatefulWidget {
//   HomePage() : super();

//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {}
// }