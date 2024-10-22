import 'package:engez/data/abstraction_database.dart';
import 'package:hive/hive.dart';

class EngezDataBase implements LocalDatabase {
  final _box = Hive.box('mybox');
  @override
  List todo = [];

  @override
  void createInitialData() {
    todo = [
      ["Make Tutorial", false],
      ["DO Excercies!", false]
    ];
    updateData();
  }

  @override
  void loadData() {
    todo = _box.get("TODOLIST")??[];
  }

  @override
  void updateData() {
    _box.put("TODOLIST", todo);
  }
}
