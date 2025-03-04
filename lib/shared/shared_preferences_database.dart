import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  static const String _key = 'tasks';
  List<String> _items = [];

  @override
  Future<int> get itemCount async {
    // await Future.delayed(const Duration(milliseconds: 100));
    // return _items.length;

    final items = await SharedPreferences.getInstance();
    final List<String>? itemsString = items.getStringList(_key);
    if (itemsString == null) {
      return 0;
    } else {
      return itemsString.length;
    }
  }

  @override
  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    _items = prefs.getStringList(_key) ?? [];
  }

  @override
  Future<List<String>> getItems() async {
    final items = await SharedPreferences.getInstance();
    return items.getStringList(_key) ?? [];
  }

  @override
  Future<void> saveItems(List<String> tasks) async {
    final items = await SharedPreferences.getInstance();
    await items.setStringList(_key, tasks);
    loadTasks();
  }

  @override
  Future<void> addItem(String item) async {
    if (item.isNotEmpty && !_items.contains(item)) _items.add(item);
  }

  @override
  Future<void> deleteItem(int index) async {
    final items = await SharedPreferences.getInstance();
    _items.removeAt(index);
    await items.setStringList(_key, _items);
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    if (newItem.isNotEmpty && !_items.contains(newItem)) {
      final items = await SharedPreferences.getInstance();
      _items[index] = newItem;
      await items.setStringList(_key, _items);
    }
  }
}
