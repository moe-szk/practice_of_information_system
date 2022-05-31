import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../top_view.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      var imagesname = [
        'images/1.png',
        'images/2.png',
        'images/3.png',
        'images/4.png',
        'images/5.png'
      ];
      final userName = ref.watch(topPageProvider.select((state) {
        return state.userName;
      }));
      final stateNumber = ref.watch(topPageProvider.select((state) {
        return state.stateNumber;
      }));
      final state1 = ref.watch(topPageProvider.select((state) {
        return state.state1;
      }));
      final state2 = ref.watch(topPageProvider.select((state) {
        return state.state2;
      }));
      final state3 = ref.watch(topPageProvider.select((state) {
        return state.state3;
      }));
      return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            Text('$userName',
                style: TextStyle(fontSize: 30, color: Colors.blue)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('images/$stateNumber.png', width: 200),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('$state1'),
                      Text('$state2'),
                      Text('$state3'),
                    ])
              ],
            )
          ]));
    });
  }
}
