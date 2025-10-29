import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_list/data/source/task_list_data_source/task_list_hive_data_source/module/task_item_hive_module.dart';
import 'package:to_do_list/data/source/task_list_data_source/task_list_hive_data_source/module/task_list_hive_module.dart';
import 'package:to_do_list/data/source/task_list_data_source/task_list_hive_data_source/task_list_hive_data_source.dart';
import 'package:to_do_list/data/task_list_label.dart';
import 'package:to_do_list/ui/on_boarding/on_boarding.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskListHiveModuleAdapter());
  Hive.registerAdapter(TaskItemHiveModuleAdapter());
  Hive.registerAdapter(TaskListLabelAdapter());
  await Hive.openBox<TaskListHiveModule>(TaskListHiveDataSource.boxName);


  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final String fontFamily = 'graphik';
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: fontFamily,
        textTheme: const TextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: const OnBoardingScreen(),
    );
  }
}
