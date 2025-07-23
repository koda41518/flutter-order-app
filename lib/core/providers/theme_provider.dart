import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeProvider extends HydratedCubit<ThemeMode> {
  ThemeProvider() : super(ThemeMode.light);

  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  ThemeMode fromJson(Map<String, dynamic> json) {
    return ThemeMode.values[json['theme'] as int];
  }

  @override
  Map<String, dynamic> toJson(ThemeMode state) {
    return {'theme': state.index};
  }

  ThemeMode get currentTheme => state;
}