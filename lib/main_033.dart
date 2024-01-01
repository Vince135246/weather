import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// More examples see https://github.com/cfug/dio/blob/main/example
void main() async {
  runApp(ProviderScope(child: MyApp()));
}

final myProvider = StateProvider((ref) => "");
//final stateProvider = StateProvider<String>((ref) => "");

// class MyApp extends ConsumerStatefulWidget {
//   const MyApp() : super();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: Scaffold(body: HomePage()));
//   }
// }

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
                        controller: myController,
                        decoration: InputDecoration(hintText: '請輸入城市名稱')),
                    height: 200,
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
                            'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWA-8A1F00F6-428C-4537-B94B-AD8DCC99711B');
                        print(response.data);
                        //strDataShow =

                        var etSearch = myController.text;
                        List<dynamic> city =
                            response.data['records']['location']; //3
                        int k = 0;
                        strDataTemp = "";
                        for (k = 0; k < city.length; k++) {
                          bool bMatch =
                              city[k]['locationName'].contains(etSearch);
                          if ("" == etSearch) {
                          } else if (false == bMatch) {
                            continue;
                          }
                          strDataTemp += city[k]['locationName'] + "\n";
                          int z = 0;
                          for (z = 0; z < 3; z++) {
                            var report =
                                city[k]['weatherElement'][0]['time'][z];
                            strDataTemp +=
                                report['startTime'].toString() + " ~ \n";
                            strDataTemp += report['endTime'].toString() + "\n";
                            strDataTemp += report['parameter']['parameterName']
                                    .toString() +
                                "\n";
                            //['startTime'] + "\n";
                            // strDataShow += city[k]['weatherElement'][z]['time']
                            //         ['endTime'] +
                            //     "\n";
                            // strDataShow += city[k]['weatherElement'][z]['time']
                            //         ['parameter']['parameerName'] +
                            //     "\n";
                            //['elementName'];

                            // if ("Wx" == strWx) {
                            //   strDataShow += city[k]['weatherElement'][0]['time']
                            //           ['startTime'] +
                            //       "\n";

                            //   strDataShow += city[k]['weatherElement'][0]['time']
                            //           ['endTime'] +
                            //       "\n";

                            // int z = 0;
                            // for (z = 0; z < elementTime.length; z++) {
                            //   var startTime_1 = elementTime[z]['startTime'];
                            //   var endTime_1 = elementTime[z]['endTime'];
                            //   var parameter_1 = elementTime[z]['parameter'];
                            //   var parameterName = parameter_1['parameterName'];

                            //   strDataShow += startTime_1 + '\n';
                            //   strDataShow += endTime_1 + '\n';
                            //   strDataShow += parameterName + '\n';
                            //   strDataShow += '\n';
                            //}
                          }
                          strDataTemp += "\n";
                        }
                        strDataTemp += "\n";

// //將 pharmaciesData 整包字串資料，轉成 JSONObject 格式
// val obj = JSONObject(LoopData)

// //features 是一個陣列 [] ，需要將他轉換成 JSONArray
// val featuresArray = JSONArray(LoopData);

// //透過 for 迴圈，即可以取出所有的藥局名稱
// for (i in 0 until featuresArray.length()) {
//     val properties = featuresArray.getJSONObject(i).getString("properties")
//     val property = JSONObject(properties)
//     Log.d("HKT", "name: ${property.getString("name")}")
//}
                        strDataShow = strDataTemp;
                        ref.read(counterProvider.notifier).state = strDataShow;
                        i = 1;
                        //setState(() {});
                      },
                    ),
                    width: 200,
                    height: 200,
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
                    height: 200,
                  ),
                  flex: 1, //权重值,上面主轴是horizontal时，仅在horizontal上生效，
                ),
                Expanded(
                  flex: 20,
                  child: Container(
                      //有flex属性，来分配权重，

                      child: ListView(children: <Widget>[
                    //if (0 == i) Text("我好\n我好"),
                    //if (0 == i) Text("你好\n你好"),
                    //if (1 == i) Text("${ref.watch(counterProvider)}"),
                    Text("${ref.watch(counterProvider)}"),
                  ])), //权重值,上面主轴是horizontal时，仅在horizontal上生效，
                ),
                Expanded(
                  //有flex属性，来分配权重，
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white38,
                    width: 200,
                    height: 200,
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
