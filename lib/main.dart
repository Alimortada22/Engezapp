import 'package:engez/data/database.dart';
import 'package:engez/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //inint hive
  await Hive.initFlutter();
  //open a box
   await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  HomePage(EngezDataBase()),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
