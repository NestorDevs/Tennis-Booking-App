import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tennis_booking_app/presentation/bloc/theme/theme_cubit.dart';

import 'theme_cubit_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  group('ThemeCubit', () {
    late MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
    });

    test('initial state is ThemeMode.system', () {
      when(mockSharedPreferences.getBool('isDarkMode')).thenReturn(null);
      expect(
        ThemeCubit(mockSharedPreferences).state,
        ThemeMode.system,
      );
    });

    blocTest<ThemeCubit, ThemeMode>(
      'emits [ThemeMode.dark] when isDarkMode is true in SharedPreferences',
      build: () {
        when(mockSharedPreferences.getBool('isDarkMode')).thenReturn(true);
        return ThemeCubit(mockSharedPreferences);
      },
      act: (cubit) => cubit.loadTheme(),
      expect: () => [ThemeMode.dark],
    );

    blocTest<ThemeCubit, ThemeMode>(
      'emits [ThemeMode.light] when isDarkMode is false in SharedPreferences',
      build: () {
        when(mockSharedPreferences.getBool('isDarkMode')).thenReturn(false);
        return ThemeCubit(mockSharedPreferences);
      },
      act: (cubit) => cubit.loadTheme(),
      expect: () => [ThemeMode.light],
    );

    blocTest<ThemeCubit, ThemeMode>(
      'emits [ThemeMode.light] when toggleTheme is called and current theme is dark',
      build: () {
        when(mockSharedPreferences.setBool('isDarkMode', false)).thenAnswer((_) async => true);
        return ThemeCubit(mockSharedPreferences);
      },
      seed: () => ThemeMode.dark,
      act: (cubit) => cubit.toggleTheme(),
      expect: () => [ThemeMode.light],
    );

    blocTest<ThemeCubit, ThemeMode>(
      'emits [ThemeMode.dark] when toggleTheme is called and current theme is light',
      build: () {
        when(mockSharedPreferences.setBool('isDarkMode', true)).thenAnswer((_) async => true);
        return ThemeCubit(mockSharedPreferences);
      },
      seed: () => ThemeMode.light,
      act: (cubit) => cubit.toggleTheme(),
      expect: () => [ThemeMode.dark],
    );
  });
}
