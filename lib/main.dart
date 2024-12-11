import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/controller/home_screen_controller/home_screen_controller.dart';
import 'package:to_do_app/view/splash_screen/splash_screen.dart';
import 'package:to_do_app/view/task_screen/task_screen.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    HomeScreenController.initialiseDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
