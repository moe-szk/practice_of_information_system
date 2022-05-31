import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'views/top_view.dart';
import 'views/history_view.dart';
import 'views/battle_view.dart';
import 'views/ranking.dart';
import 'views/widgets/bottom_navbar.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, title}) : super(key: key);
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, ref, child) {
      final notifier = ref.read(homePageProvider.notifier);
      return Scaffold(
          body: PageView(
            controller: _pageController,
            children: <Widget>[
              TopPage(),
              RankingPage(),
              HistoryPage(),
            ],
            onPageChanged: (index) {
              print(index);
              notifier.setIndex(index);
            },
          ),
          bottomNavigationBar: BottomBar(_pageController));
    }));
  }
}

// ① 状態クラス
@immutable
class HomePageState {
  final int selectedIndex;

  HomePageState({this.selectedIndex = 0});

  HomePageState copyWith({int? selectedIndex}) {
    return HomePageState(selectedIndex: selectedIndex ?? this.selectedIndex);
  }
}

// ② 状態を変更するロジッククラス
class HomePageStateNotifier extends StateNotifier<HomePageState> {
  HomePageStateNotifier() : super(HomePageState());

  void setIndex(index) {
    state = state.copyWith(selectedIndex: index);
  }

  // ToDo: ステータスの更新
  // void updateStatus() {}
}

// ③ グローバルなProvider
final homePageProvider =
    StateNotifierProvider<HomePageStateNotifier, HomePageState>((ref) {
  return HomePageStateNotifier();
});
