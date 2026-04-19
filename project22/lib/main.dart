import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/task_controller.dart';
import 'controllers/timer_controller.dart';
import 'features/home/widgets/home_page.dart';
import 'core/constant/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Timer',
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        appBarTheme: AppBarTheme(
          backgroundColor: primary,
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
    );
  }
}

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TaskController());
    Get.put(TimerController());
  }
}
