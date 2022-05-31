import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/history_model.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('History'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              child: FutureBuilder<List>(
                future: _getHistory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        cacheExtent: 0.0,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return ConstrainedBox(
                              constraints:
                                  const BoxConstraints(minHeight: 100.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      // Image.memory(
                                      //   base64Decode(
                                      //       snapshot.data![index].imageBase64),
                                      //   height: 100,
                                      //   fit: BoxFit.cover,
                                      // ),
                                      Image.asset(
                                        'images/1.png',
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(width: 20),
                                      Text(DateFormat('yyyy-MM-dd(E) hh:mm')
                                          .format(DateTime.parse(
                                              snapshot.data![index].createdAt))
                                          .toString()),
                                    ]),
                                    const Divider()
                                  ]));
                        });
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )));
  }

  Future<List> _getHistory() async {
    // String url = "http://localhost:8000/get-history/{userId}";
    String url = "https://api.github.com/users";
    final res = await http.get(Uri.parse(url));
    if (res == null) return [null];
    final body = json.decode(res.body);
    // final user = User.fromJson(json.decode(body["data"]));
    const tmpData = '''[
  {
    "id": 0,
    "userId": 0,
    "imageBase64": "string",
    "createdAt": "2022-05-24T04:29:21.107Z"
  },
  {
    "id": 1,
    "userId": 1,
    "imageBase64": "string",
    "createdAt": "2022-05-24T04:29:21.107Z"
  }]''';
    List histJson = json.decode(tmpData);
    var tmp = await Future.delayed(const Duration(seconds: 1))
        .whenComplete(() => histJson);
    List histObj = histJson.map((e) => History.fromJson(e)).toList();
    print(histObj);
    return histObj;
  }
}
