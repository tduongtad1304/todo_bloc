part of 'theme_cubit.dart';

enum AppTheme { light, dark }

class ThemeState extends Equatable {
  const ThemeState({
    required this.theme,
  });

  final AppTheme theme;

  factory ThemeState.initial() => const ThemeState(
        theme: AppTheme.light,
      );

  @override
  List<Object> get props => [theme];

  ThemeState copyWith({
    AppTheme? theme,
  }) {
    return ThemeState(
      theme: theme ?? this.theme,
    );
  }

  @override
  String toString() => 'ThemeState(theme: $theme)';

  String enumToString() => theme.toString().split('.').last.split(')').first;

  Map<String, dynamic> toMap() {
    return {
      'theme': theme.index,
    };
  }

  factory ThemeState.fromMap(Map<String, dynamic> map) {
    int value = map['theme'];
    return ThemeState(
      theme: map[value],
    );
  }

  String toJson() => json.encode(toMap());

  factory ThemeState.fromJson(String source) =>
      ThemeState.fromMap(json.decode(source));
}
