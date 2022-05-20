import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/cubits.dart';

class TodoHeader extends StatefulWidget {
  const TodoHeader({Key? key}) : super(key: key);

  @override
  State<TodoHeader> createState() => _TodoHeaderState();
}

class _TodoHeaderState extends State<TodoHeader> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        flex: 2,
        child: Stack(
          children: [
            Text(
              'TODO',
              style: TextStyle(
                fontSize: 40.0,
                color: isSwitched
                    ? Colors.white
                    : const Color.fromARGB(178, 0, 0, 0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 110.0),
              child: IconButton(
                visualDensity: VisualDensity.adaptivePlatformDensity,
                onPressed: () {
                  setState(() {
                    isSwitched = !isSwitched;
                  });
                  context.read<ThemeCubit>().switchTheme(isSwitched);
                },
                iconSize: 30.0,
                icon: isSwitched
                    ? const Icon(
                        Icons.sunny,
                      )
                    : const Icon(
                        Icons.nights_stay,
                      ),
              ),
            ),
          ],
        ),
      ),
      Expanded(
        flex: 1,
        child: Text(
          '${context.watch<ActiveTodoCountCubit>().state.activeTodoCount} items left',
          style: const TextStyle(fontSize: 20.0, color: Colors.redAccent),
        ),
      ),
    ]);
  }
}
