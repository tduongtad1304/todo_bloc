import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../cubits/cubits.dart';
import '../../models/todo_model.dart';

class ShowTodo extends StatefulWidget {
  const ShowTodo({Key? key}) : super(key: key);

  @override
  State<ShowTodo> createState() => _ShowTodoState();
}

class _ShowTodoState extends State<ShowTodo> {
  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodoCubit>().state.filteredTodos;

    return Scrollbar(
      thickness: 5.0,
      child: ListView.builder(
          physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
          primary: true,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: ValueKey(todos[index].id),
              background: showBackground(0),
              secondaryBackground: showBackground(1),
              child: TodoItem(
                todo: todos[index],
              ),
              confirmDismiss: (_) {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Are you sure?'),
                        content: const Text('Do you really want to delete?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: const Text('NO')),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                                showTopSnackBar(
                                    context,
                                    CustomSnackBar.success(
                                        message: 'Deleted successfully the ' +
                                            todos[index].desc +
                                            '!'),
                                    displayDuration: const Duration(
                                      milliseconds: 1800,
                                    ));
                              },
                              child: const Text('YES')),
                        ],
                      );
                    });
              },
              onDismissed: (_) {
                context.read<TodoListCubit>().removeTodo(todos[index]);
              },
            );
          },
          // separatorBuilder: (BuildContext context, int index) {
          //   return const Divider(
          //     thickness: 1.3,
          //     color: Colors.grey,
          //   );
          // },
          itemCount: todos.length),
    );
  }

  Widget showBackground(int direction) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      color: direction == 0 ? Colors.red : const Color.fromARGB(255, 168, 9, 9),
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 30.0,
        color: Colors.white,
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({Key? key, required this.todo}) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textController;
  Filter? filter;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              bool _error = false;
              textController.text = widget.todo.desc;
              String? errorMessage;
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter stateSetter) {
                return AlertDialog(
                  title: const Text('Edit Todo'),
                  content: TextField(
                    controller: textController,
                    autofocus: true,
                    decoration: InputDecoration(
                      errorText: _error ? errorMessage! : null,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (textController.text.trim().isEmpty ||
                            textController.text.trim() == widget.todo.desc) {
                          stateSetter(() {
                            _error = true;
                            errorMessage = textController.text.trim().isEmpty
                                ? 'Please input the description.'
                                : 'Same description is already exist.';
                          });
                        } else {
                          stateSetter(() {
                            _error = false;
                          });
                        }
                        if (!_error) {
                          context
                              .read<TodoListCubit>()
                              .editTodo(widget.todo.id, textController.text);
                          Navigator.of(context).pop();
                          showTopSnackBar(
                              context,
                              CustomSnackBar.success(
                                  message: 'Todo edited successfully to ' +
                                      textController.text),
                              displayDuration: const Duration(
                                milliseconds: 1800,
                              ));
                        }
                      },
                      child: const Text('Edit'),
                    ),
                  ],
                );
              });
            });
      },
      leading: Checkbox(
          value: widget.todo.completed,
          onChanged: (bool? checked) {
            context.read<TodoListCubit>().toggleTodo(widget.todo.id);
          }),
      title: Text(widget.todo.desc),
    );
  }
}
