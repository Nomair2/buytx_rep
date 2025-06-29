import 'package:buytx/core/common/singletons/cache_helper.dart';
import 'package:buytx/core/configs/theme/app_theme.dart';
import 'package:buytx/core/services/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void toggleTheme() {
    ThemeData.dark();
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  void setTheme(ThemeMode themeMode) {
    emit(themeMode);
  }

  bool get isDarkMode => state == ThemeMode.dark;
}

// class ThemeState extends Equatable {
//   final ThemeData themeData;
//   const ThemeState(this.themeData);
//   @override
//   List<Object> get props => [themeData];
// }

// class ThemeCubit extends Cubit<ThemeState> {
//   ThemeCubit() : super(ThemeState(AppTheme.lightTheme));

//    getTheme() {
//     bool? isDark = sl<CacheHelper>().getTheme();
//     return isDark == null || isDark ? AppTheme.darkTheme : AppTheme.lightTheme;
//   }
//   changeTheme(){

//   }
// }
