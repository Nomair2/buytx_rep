import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buytx/src/home/bloc/chooce_bloc/choose_state.dart';

class ChooseBloc extends Cubit<int> {
  ChooseBloc() : super(0);

  changeIndex(int index) {
    emit(index);
  }
}
