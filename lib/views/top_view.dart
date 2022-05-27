import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice_of_information_system/views/widgets/camera_button.dart';

import './widgets/avatar.dart';
//import './widgets/camera_button.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}): super(key: key);

  @override 
  Widget build(BuildContext cotext) {
    
    return ProviderScope ( 
      child: Column(  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Avatar(),
          CameraButton()
        ],
      )
    );
  }
}

// ①State class
@immutable 
class TopPageState {
  const TopPageState({
    this.stateNumber = 0,
    this.userName = 'You',
    this.isLoading = false,
    this.state1 = 0,
    this.state2 = 0,
    this.state3 = 0,
  });

  final int stateNumber;
  final String userName;
  final bool isLoading;
  final int state1;
  final int state2;
  final int state3;

  TopPageState copyWith({
    int?stateNumber, 
    String? userName,
    bool? isLoading,
    int? state1,
    int? state2,
    int? state3,
    }) {
    return TopPageState (
      stateNumber: stateNumber??this.stateNumber,
      userName: userName ?? this.userName,
      isLoading : isLoading??this.isLoading,
      state1 : state1 ?? this.state1,
      state2 : state2 ?? this.state2,
      state3 : state3 ?? this.state3,
      );
  }
}

// ②class notifier
class TopPageStateNotifier extends StateNotifier<TopPageState> {
  TopPageStateNotifier(): super(const TopPageState());
  // void increment() {}
  void updateState() {
    state = state.copyWith(stateNumber: state.stateNumber+1);
  }
}

// ③ global provider
final topPageProvider = StateNotifierProvider<TopPageStateNotifier,TopPageState>((ref) {return TopPageStateNotifier();});
