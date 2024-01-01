import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  runApp(ProviderScope(child: MyApp()));
}

final myProvider = StateProvider((ref) => "");

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: HomePage()));
  }
}

final counterProvider = StateProvider((ref) => "");

class HomePage extends ConsumerWidget {
  HomePage({super.key});
  final TextEditingController myController = new TextEditingController();

  int i = 0;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String strDataShow = "";

    String strDataTemp = "";
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
                height: 200,
              ),
              flex: 8,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Text('確認'),
                  onPressed: () async {
                    ref.read(counterProvider.notifier).state = "讀取中...";
                    Dio dio = Dio();
                    Response response = await dio.get(
                        'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWA-8A1F00F6-428C-4537-B94B-AD8DCC99711B');
                    print(response.data);

                    var etSearch = myController.text;
                    List<dynamic> city =
                        response.data['records']['location']; //3
                    int k = 0;
                    strDataTemp = "";
                    for (k = 0; k < city.length; k++) {
                      bool bMatch = city[k]['locationName'].contains(etSearch);
                      if ("" == etSearch) {
                      } else if (false == bMatch) {
                        continue;
                      }
                      strDataTemp += city[k]['locationName'] + "\n";
                      int z = 0;
                      for (z = 0; z < 3; z++) {
                        var report = city[k]['weatherElement'][0]['time'][z];
                        strDataTemp += report['startTime'].toString() + " ~ \n";
                        strDataTemp += report['endTime'].toString() + "\n";
                        strDataTemp +=
                            report['parameter']['parameterName'].toString() +
                                "\n";
                      }
                      strDataTemp += "\n";
                    }
                    strDataTemp += "\n";
                    strDataShow = strDataTemp;
                    ref.read(counterProvider.notifier).state = strDataShow;
                    i = 1;
                    //setState(() {});
                  },
                ),
                width: 200,
                height: 200,
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
                height: 200,
              ),
              flex: 1,
            ),
            Expanded(
              flex: 20,
              child: Container(
                  child: ListView(children: <Widget>[
                Text("${ref.watch(counterProvider)}"),
              ])),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.white38,
                width: 200,
                height: 200,
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
        ),
      ],
    );
  }
}
