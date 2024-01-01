import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// More examples see https://github.com/cfug/dio/blob/main/example
void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: HomePage()));
  }
}

class HomePage extends StatefulWidget {
  HomePage() : super();

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _list = [];
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical, //horizontal垂直类似row,
      children: [
        Expanded(
          //有flex属性，来分配权重，

          child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.lightGreen,
          ),
          flex: 1, //权重值,长宽就失效了
        ),
        Expanded(
          //有flex属性，来分配权重，

          child: Flex(
              direction: Axis.horizontal, //horizontal垂直类似row,
              children: [
                Expanded(
                  //有flex属性，来分配权重，
                  child: Container(
                    color: Colors.white38,
                    padding: EdgeInsets.all(10),
                    child: TextField(
                        decoration: InputDecoration(hintText: '請輸入城市名稱')),
                    //height: 200,
                  ),
                  flex: 8, //权重值,上面主轴是horizontal时，仅在horizontal上生效，
                ),
                Expanded(
                  //有flex属性，来分配权重，
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      child: Text('確認'),
                      onPressed: () async {
                        Dio dio = Dio();
                        Response response = await dio.get(
                            'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWA-8A1F00F6-428C-4537-B94B-AD8DCC99711B&locationName=');
                        print((response.data));
                        List<dynamic> dataList = jsonDecode(response.data["result"]);
                        setState() {
                          this._list = json.decode(response.data)["result"];
                        }
                      },
                    ),
                    //width: 200,
                    //height: 200,
                  ),
                  flex: 2, //权重值,上面主轴是horizontal时，仅在horizontal上生效，
                ),
              ]),
          flex: 2, //权重值,上面主轴是horizontal时，仅在horizontal上生效，
        ),
        Expanded(
          //有flex属性，来分配权重，

          child: Flex(
              direction: Axis.horizontal, //horizontal垂直类似row,
              children: [
                Expanded(
                  //有flex属性，来分配权重，
                  child: Container(
                    color: Colors.white38,
                    padding: EdgeInsets.all(10),
                    //child: TextField(
                    //    decoration: InputDecoration(hintText: '請輸入城市名稱')),
                    //height: 200,
                  ),
                  flex: 1, //权重值,上面主轴是horizontal时，仅在horizontal上生效，
                ),
                Expanded(
                  child: Container(
                      //有flex属性，来分配权重，
                      child: Column(children: <Widget>[
                    Text("$(this._list)"),
                    Text("我好\n我好")
                  ])),
                  //child: Container(
                  //    padding: EdgeInsets.all(10), color: Colors.lightBlueAccent

                  //width: 200,
                  //height: 200,
                  //),

                  flex: 20, //权重值,上面主轴是horizontal时，仅在horizontal上生效，
                ),
                Expanded(
                  //有flex属性，来分配权重，
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white38,
                    //width: 200,
                    //height: 200,
                  ),
                  flex: 1, //权重值,上面主轴是horizontal时，仅在horizontal上生效，
                )
              ]),
          flex: 18, //权重值,长宽就失效了
        ),
        Expanded(
          //有flex属性，来分配权重，

          child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.lightGreen,
            height: 200,
          ),
          flex: 1, //权重值,长宽就失效了
        ),
      ],
    );
  }
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       child: Text('獲取天氣資訊'),
//       onPressed: () async {
//         final dio = Dio();
//         final response = await dio.get(
//             'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWA-8A1F00F6-428C-4537-B94B-AD8DCC99711B&locationName=');
//         print(response.data);
//       },
//     );
//   }
// }

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
