import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences sharedPreferences;

  ThemeCubit(this.sharedPreferences) : super(ThemeMode.system);

  void loadTheme() {
    final isDarkMode = sharedPreferences.getBool('isDarkMode');
    if (isDarkMode != null) {
      emit(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    }
  }

  void toggleTheme() {
    final newThemeMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    sharedPreferences.setBool('isDarkMode', newThemeMode == ThemeMode.dark);
    emit(newThemeMode);
  }
}
