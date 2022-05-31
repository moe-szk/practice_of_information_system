import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'top_view.dart';
import '../models/history_model.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final id = ref.watch(topPageProvider.select((state) {
        return state.id;
      }));
      return Scaffold(
          appBar: AppBar(
            title: Text('History'),
          ),
          body: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                child: FutureBuilder<List>(
                  future: _getHistory(id),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(children: <Widget>[
                                        Image.memory(
                                          base64Decode(snapshot
                                              .data![index].imageBase64),
                                          width: 120,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(width: 20),
                                        Text(DateFormat('yyyy-MM-dd(E) hh:mm')
                                            .format(DateTime.parse(snapshot
                                                .data![index].createdAt))
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
    });
  }

  Future<List> _getHistory(int id) async {
    print("id : $id");
    String url = "http://localhost:8000/get-history/$id";
    final res = await http.get(Uri.parse(url));
    if (res == null) return [null];
    List histJson = json.decode(res.body);
    // var tmp = await Future.delayed(const Duration(seconds: 1))
    //     .whenComplete(() => histJson);
    List histObj = histJson.map((e) => History.fromJson(e)).toList();
    print(histObj);
    return histObj;
  }
}
