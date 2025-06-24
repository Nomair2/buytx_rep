import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:buytx/core/error/failure.dart';
import 'package:buytx/core/usercase/usecase.dart';
import 'package:buytx/core/utils/typedefs.dart';

part 'button_state.dart';

class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(ButtonInitialState());

  Future<void> execute({dynamic params, required UseCase usecase}) async {
    emit(ButtonLoadingState());
    Either<Failure, dynamic> returnedDate = await usecase.call(params);
    returnedDate.fold(
      (error) {
        emit(ButtonFailureState(errorMessage: error.errorMessage));
      },
      (r) {
        emit(ButtonSuccessState());
      },
    );
  }
}
