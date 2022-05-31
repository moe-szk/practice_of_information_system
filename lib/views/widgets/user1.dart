import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_of_information_system/my_flutter_app_icons.dart';

import '../battle_view.dart';

class User1 extends StatelessWidget {
  const User1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, ref, child) {
      final hp = ref.watch(battlePageProvider.select((state) {
        return state.user1Hp;
      }));
      final state = ref.watch(battlePageProvider.select((state) {
        return state.user1State;
      }));
      final status1 = ref.watch(battlePageProvider.select((state) {
        return state.user1Status1;
      }));
      final status2 = ref.watch(battlePageProvider.select((state) {
        return state.user1Status2;
      }));
      final status3 = ref.watch(battlePageProvider.select((state) {
        return state.user1Status3;
      }));
      final item = ref.watch(battlePageProvider.select((state) {
        return state.user1Item;
      }));
      List i = [
        Icons.circle_outlined,
        MyFlutterApp.hand_grab_o,
        MyFlutterApp.hand_scissors_o,
        MyFlutterApp.hand
      ];
      return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('あなた'),
              Text('HP: $hp/100'),
              Image.asset(
                'images/$state.png',
                width: 100,
              ),
              Text('✊: $status1'),
              Text('✌️: $status2'),
              Text('✋: $status3'),
              //Text('${i[item]}'),
              Icon(
                i[item],
                color: Colors.blue,
              ),
              //Text(i[item-1]),
            ]),
      );
    }));
  }
}
