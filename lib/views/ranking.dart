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
              leading: Image.asset('images/3.png'),
              title: Text('user1'),
            ),
            ListTile(
              leading: Image.asset('images/3.png'),
              title: Text('user2'),
            ),
            ListTile(
              leading: Image.asset('images/2.png'),
              title: Text('user3'),
            ),
            ListTile(
              leading: Image.asset('images/4.png'),
              title: Text('user4'),
            ),
            ListTile(
              leading: Image.asset('images/1.png'),
              title: Text('user5'),
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