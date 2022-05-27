import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_of_information_system/my_flutter_app_icons.dart';

import '../battle_view.dart';

class Buttons extends StatelessWidget {
  const Buttons ({Key? key}): super(key:key);
  
  @override  
  Widget build(BuildContext context) {
    return Consumer(builder:(context,ref,child) {
      final notifier = ref.read(battlePageProvider.notifier);
      final winner = ref.watch(battlePageProvider.select((state){return state.winner;}));
      return Center(child:
        Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('$winner'),
            FloatingActionButton(onPressed:(() {notifier.initBattle();}), child: Icon(Icons.refresh)),
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