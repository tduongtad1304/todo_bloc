// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../cubits/cubits.dart';

// class ConfirmButton extends StatefulWidget {
//   const ConfirmButton({Key? key}) : super(key: key);

//   @override
//   State<ConfirmButton> createState() => _ConfirmButtonState();
// }

// class _ConfirmButtonState extends State<ConfirmButton> {
//   bool isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//             child: SizedBox(
//           width: 40,
//           height: 40,
//           child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.redAccent,
//                 padding: const EdgeInsets.all(10.0),
//               ),
//               onPressed: () => context.read<TodoListCubit>().removeAllTodos(),
//               child: const Text(
//                 'Delete All Todos',
//                 style: TextStyle(fontSize: 17),
//               )),
//         )),
//         const SizedBox(width: 10.0),
//         Expanded(
//           child: SizedBox(
//             width: 40,
//             height: 40,
//             child: ElevatedButton(
//               onPressed: () async {
//                 setState(() {
//                   isLoading = true;
//                 });
//                 await Future.delayed(const Duration(seconds: 2));
//                 setState(() {
//                   isLoading = false;
//                 });

//                 context.read<TodoListCubit>().loadDefaultTodos();
//               },
//               child: (isLoading)
//                   ? const SizedBox(
//                       width: 16,
//                       height: 16,
//                       child: CircularProgressIndicator(
//                         color: Colors.white,
//                         strokeWidth: 2,
//                       ))
//                   : const Text(
//                       'Load Default Todo',
//                       style: TextStyle(fontSize: 15),
//                     ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
