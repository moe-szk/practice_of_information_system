import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_of_information_system/my_flutter_app_icons.dart';

import '../battle_view.dart';


class User2 extends StatelessWidget {
  const User2({Key? key}): super(key: key);

  @override  
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, ref,child) {
      final hp = ref.watch(battlePageProvider.select((state){return state.user2Hp;}));
      final status1 = ref.watch(battlePageProvider.select((state){return state.user2Status1;}));
      final status2 = ref.watch(battlePageProvider.select((state){return state.user2Status2;}));
      final status3 = ref.watch(battlePageProvider.select((state){return state.user2Status3;}));
      final item = ref.watch(battlePageProvider.select((state){return state.user2Item;}));
      final int state = 3;
      List i = [Icons.circle_outlined,MyFlutterApp.hand_grab_o,MyFlutterApp.hand_scissors_o,MyFlutterApp.hand];
      return Center(child: 
      Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: <Widget>[
              Text('User2'),
              Text('HP: $hp/100'),
              Image.asset('images/$state.png',width: 100,),
              Text('✊: $status1'),
              Text('✌️: $status2'),
              Text('✋: $status3'),
              Icon(i[item],color:Colors.red,),
              //Text(i[item-1]),
              ]),
            );
    }));
  }
}