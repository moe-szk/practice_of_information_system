import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_of_information_system/my_flutter_app_icons.dart';

import '../battle_view.dart';
import '../top_view.dart';

class Buttons extends StatelessWidget {
  const Buttons ({Key? key}): super(key:key);
  
  @override  
  Widget build(BuildContext context) {
    return Consumer(builder:(context,ref,child) {
      final notifier = ref.read(battlePageProvider.notifier);
      final winner = ref.watch(battlePageProvider.select((state){return state.winner;}));

      final stateNumber = ref.watch(topPageProvider.select((state){return state.stateNumber;}));
      final state1 = ref.watch(topPageProvider.select((state){return state.state1;}));
      final state2 = ref.watch(topPageProvider.select((state){return state.state2;}));
      final state3 = ref.watch(topPageProvider.select((state){return state.state3;}));

      return Center(child:
        Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('$winner'),
            FloatingActionButton(onPressed:(() {notifier.initBattle(stateNumber,state1,state2,state3);}), child: Icon(Icons.refresh_outlined),backgroundColor: Colors.white,foregroundColor:Colors.blue),
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
              FloatingActionButton(onPressed:(() {notifier.rock();}), child: Icon(MyFlutterApp.hand_grab_o)),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    FloatingActionButton(onPressed:(() {notifier.scis();}) , child: Icon(MyFlutterApp.hand_scissors_o)),
                    FloatingActionButton(onPressed:(() {notifier.paper();}), child: Icon(MyFlutterApp.hand)),
                ]
              )
            ]),
          ],
        )
      );
      }
    );
  }
}