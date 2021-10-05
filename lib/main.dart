import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/features/presentation/cubit/cubit/task_cubit.dart';
import 'package:todo_list_app/features/presentation/screens/home_screen.dart';
import 'package:todo_list_app/on_generate_route.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskCubit>(
      create: (_) => di.sl<TaskCubit>()
        ..openDatabase()
        ..initNotification(),
      child: MaterialApp(
        title: 'My Daily Task',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.redAccent),
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": (context) {
            return const HomeScreen();
          }
        },
      ),
    );
  }
}
