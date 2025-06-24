part of 'button_cubit.dart';

sealed class ButtonState extends Equatable {
  const ButtonState();

  @override
  List<Object> get props => [];
}

final class ButtonInitialState extends ButtonState {}

final class ButtonLoadingState extends ButtonState {}

final class ButtonSuccessState extends ButtonState {}

final class ButtonFailureState extends ButtonState {
  String errorMessage;
  ButtonFailureState({required this.errorMessage});
}
