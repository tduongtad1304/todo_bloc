import 'package:flutter/material.dart';
import 'package:todo_bloc/pages/todo_pages/create_todo.dart';
import 'package:todo_bloc/pages/todo_pages/show_todo.dart';

import 'search_and_filter_todo.dart';
import 'todo_header.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 40.0,
          ),
          child: Column(
            children: [
              const TodoHeader(),
              const CreateTodo(),
              const SizedBox(height: 20.0),
              SearchAndFilterTodo(),
              const Expanded(child: ShowTodo()),
              const SizedBox(height: 20.0),
              // const ConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }
}
