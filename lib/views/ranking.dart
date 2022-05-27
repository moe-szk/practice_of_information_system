import 'package:flutter/material.dart';

import './battle_view.dart';

class RankingPage extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar:AppBar(
        title: Text("Ranking"),
      ),
      body: Container( 
        child: ListView( 
          children: <Widget>[ 
            ListTile(
              leading: Text('1'),
              title: Text('user1'),
            ),
            ListTile(
              leading:Text('2'),
              title: Text('user2'),
            ),
            ListTile(
              leading: Text('3'),
              title: Text('user3'),
            ),
            ListTile(
              leading: Text('4'),
              title: Text('user3'),
            ),
            ListTile(
              leading: Text('5'),
              title: Text('user3'),
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Scaffold(  appBar: AppBar(title: Text('Battle'),),body: BattlePage())));
        },
        child: new Icon(Icons.local_fire_department ),
      ),
      
    );
  }
}