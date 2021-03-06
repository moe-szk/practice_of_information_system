import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './widgets/avatar.dart';
import './widgets/camera_button.dart';
import 'widgets/loading_widget.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child: Stack(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[Avatar(), CameraButton()],
      ),
      const LoadingWidget(),
    ]));
  }
}

// ①State class
@immutable
class TopPageState {
  const TopPageState({
    this.id = 0,
    this.stateNumber = 0,
    this.userName = 'You',
    this.isLoading = false,
    this.state1 = 0,
    this.state2 = 0,
    this.state3 = 0,
  });

  final int id;
  final int stateNumber;
  final String userName;
  final bool isLoading;
  final int state1;
  final int state2;
  final int state3;

  TopPageState copyWith({
    int? id,
    int? stateNumber,
    String? userName,
    bool? isLoading,
    int? state1,
    int? state2,
    int? state3,
  }) {
    return TopPageState(
      id: id ?? this.id,
      stateNumber: stateNumber ?? this.stateNumber,
      userName: userName ?? this.userName,
      isLoading: isLoading ?? this.isLoading,
      state1: state1 ?? this.state1,
      state2: state2 ?? this.state2,
      state3: state3 ?? this.state3,
    );
  }
}

// ②class notifier
class TopPageStateNotifier extends StateNotifier<TopPageState> {
  TopPageStateNotifier() : super(const TopPageState());
  // void increment() {}
  void updateStatus(status, stapleValue, mainValue, sideValue) {
    state = state.copyWith(
        stateNumber: status,
        state1: stapleValue,
        state2: mainValue,
        state3: sideValue);
    print("status is updated to $status");
  }

  void startLoading() {
    state = state.copyWith(isLoading: true);
  }

  void stopLoading() {
    state = state.copyWith(isLoading: false);
  }

  void register(id, userName, status, stapleValue, mainValue, sideValue) {
    state = state.copyWith(
        id: id,
        userName: userName,
        stateNumber: status,
        state1: stapleValue,
        state2: mainValue,
        state3: sideValue);
  }
}

// ③ global provider
final topPageProvider =
    StateNotifierProvider<TopPageStateNotifier, TopPageState>((ref) {
  return TopPageStateNotifier();
});
