// timer_cubit.dart
import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buytx/core/error/failure.dart';
import 'package:buytx/core/services/injection_container.dart';
import 'package:buytx/src/auth/domain/usercase/verify_account.dart';

class TimerCubit extends Cubit<int> {
  TimerCubit() : super(60);

  Timer? _timer;

  void startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    emit(60);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        emit(state - 1);
      } else {
        timer.cancel();
      }
    });
  }

  void reSendOtp(String email) async {
    if (state == 0) {
      print("1");
      Either<Failure, void> dataReturn = await sl<VerifyAccountUseCase>().call(
        email,
      );
      print("2");
      dataReturn.fold((l) => print(l.errorMessage), (r) => print('success'));
    }
  }

  Future<String?> resetTimer(String email) async {
    Either<Failure, void> dataReturn = await sl<VerifyAccountUseCase>().call(
      email,
    );
    return dataReturn.fold(
      (l) {
        print(l.errorMessage);
        return '${l.errorMessage}';
      },
      (r) {
        print('successfully');
        startTimer();
        return null;
      },
    );
    // startTimer(); // Just restart
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
