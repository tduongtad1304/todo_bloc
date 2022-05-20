import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'cubits/cubits.dart';
import 'pages/todo_pages/todos_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(() => runApp(const MyApp()), storage: storage);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider<TodoFilterOptionsCubit>(
          create: (context) => TodoFilterOptionsCubit(),
        ),
        BlocProvider<TodoSearchCubit>(
          create: (context) => TodoSearchCubit(),
        ),
        BlocProvider<TodoListCubit>(
          create: (context) => TodoListCubit(),
        ),
        BlocProvider<ActiveTodoCountCubit>(
          create: (context) => ActiveTodoCountCubit(
              initialActiveTodoCount:
                  context.read<TodoListCubit>().state.todos.length,
              todoListCubit: BlocProvider.of<TodoListCubit>(context)),
        ),
        BlocProvider<FilteredTodoCubit>(
          create: (context) => FilteredTodoCubit(
              initialListTodo: context.read<TodoListCubit>().state.todos,
              todoFilterCubit: BlocProvider.of<TodoFilterOptionsCubit>(context),
              todoSearchCubit: BlocProvider.of<TodoSearchCubit>(context),
              todoListCubit: BlocProvider.of<TodoListCubit>(context)),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Todo Apps',
            debugShowCheckedModeBanner: false,
            theme: state.theme == AppTheme.light
                ? ThemeData.light()
                : ThemeData.dark(),
            home: const TodosPage(),
          );
        },
      ),
    );
  }
}
