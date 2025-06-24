import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoTimerState {
  final int seconds;
  final bool isRecording;

  VideoTimerState({required this.seconds, required this.isRecording});
}

class VideoTimerCubit extends Cubit<VideoTimerState> {
  Timer? _timer;

  VideoTimerCubit() : super(VideoTimerState(seconds: 0, isRecording: false));

  void startTimer() {
    emit(VideoTimerState(seconds: 0, isRecording: true));
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(VideoTimerState(seconds: state.seconds + 1, isRecording: true));
    });
  }

  void stopTimer() {
    _timer?.cancel();
    emit(VideoTimerState(seconds: 0, isRecording: false));
  }

  void pauseTimer() {
    _timer?.cancel();
    emit(VideoTimerState(seconds: state.seconds, isRecording: false));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
