import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

/// More examples see https://github.com/cfug/dio/blob/main/example
void main() async {
  final dio = Dio();
  final response = await dio.get('https://pub.dev');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('xxx')),
            body: ElevatedButton(
              child: Text('獲取天氣資訊'),
              onPressed: () async {
                final dio = Dio();
                final response = await dio.get(
                    'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWA-8A1F00F6-428C-4537-B94B-AD8DCC99711B&locationName=');
                print(response.data);
              },
            )));
  }
}

// class Home extends StatefulWidget{
//   @override
//   Widget build(BuildCOntext context) {

//   }
// }
// List<Widget> _getData() {
//   List<WIdget> list = new List();
//   for (var i = 0; i < 20; i++) {
//     list.add(ListTile(title: Text("我是$i列表")));
//   }
// }
