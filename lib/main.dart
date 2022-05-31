import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home.dart';
import 'views/sign_up.dart';

void main() {
  runApp(ProviderScope(child: const MyHomeApp()));
}

class MyHomeApp extends StatelessWidget {
  const MyHomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/sign-up',
        routes: {
          '/sign-up': (context) => SimpleLoginScreen(),
          '/': (context) => MyApp()
        });
  }
}
