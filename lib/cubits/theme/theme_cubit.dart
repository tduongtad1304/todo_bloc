import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> with HydratedMixin {
  ThemeCubit() : super(ThemeState.initial());

  void switchTheme(bool _isSwitched) {
    emit(state.copyWith(theme: _isSwitched ? AppTheme.dark : AppTheme.light));
    log('ThemeState: switchTheme to ' + state.enumToString());
  }

  @override
  Map<String, dynamic> toJson(ThemeState state) {
    return {
      'theme': state.toMap(),
    };
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromMap(json);
  }
}
