import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class PasswordVisibilityCubit extends Cubit<bool> {
  PasswordVisibilityCubit() : super(true); // true = obscureText ON

  void toggleVisibility() => emit(!state);
}

class ConfirmPasswordVisibilityCubit extends Cubit<bool> {
  ConfirmPasswordVisibilityCubit() : super(true); // true = obscureText ON

  void toggleVisibility() => emit(!state);
}
