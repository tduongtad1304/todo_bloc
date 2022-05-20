import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/utils/debounce.dart';

import '../../cubits/cubits.dart';
import '../../models/todo_model.dart';

class SearchAndFilterTodo extends StatelessWidget {
  SearchAndFilterTodo({Key? key}) : super(key: key);
  final debounce = Debounce(milliseconds: 1000);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Search todos...',
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (String? newSearchTerm) {
            if (newSearchTerm != null) {
              debounce.run(() {
                context.read<TodoSearchCubit>().setSearchTerm(newSearchTerm);
              });
              log(newSearchTerm.toString());
            }
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterButton(context, Filter.all),
            filterButton(context, Filter.active),
            filterButton(context, Filter.completed),
          ],
        )
      ],
    );
  }
}

Widget filterButton(BuildContext context, Filter filter) {
  return TextButton(
    onPressed: () {
      context.read<TodoFilterOptionsCubit>().changeFilter(filter);
    },
    child: Text(
      filter == Filter.all
          ? 'All 📃'
          : filter == Filter.active
              ? 'Active 🔔'
              : 'Completed ✅',
      style: TextStyle(
        fontSize: 18.0,
        color: textColor(context, filter),
      ),
    ),
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(10.0),
      primary: context.watch<ThemeCubit>().state.theme == AppTheme.light
          ? Colors.blue
          : const Color.fromARGB(255, 4, 248, 224),
    ),
  );
}

Color textColor(BuildContext context, Filter filter) {
  return context.watch<TodoFilterOptionsCubit>().state.filter == filter
      ? Colors.blue
      : Colors.grey;
}
