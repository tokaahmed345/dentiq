import 'package:bloc/bloc.dart';
import 'package:dentiq/core/utils/constant/constant.dart';
import 'package:dentiq/core/utils/service_locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);
  Future<void> loadTheme() async {
    final prefs =  getIt.get<SharedPreferences>();
    final isDark = prefs.getBool(Constant.keyTheme) ?? false;
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = state == ThemeMode.dark;
    await prefs.setBool(Constant.keyTheme, !isDark);
    emit(isDark ? ThemeMode.light : ThemeMode.dark);
  }

  Future<void> clearTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(Constant.keyTheme);
    emit(ThemeMode.light);
  }
}

