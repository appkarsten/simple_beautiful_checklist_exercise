abstract class DatabaseRepository {
  // Gibt die Anzahl der Items zurück.
  Future<int> get itemCount;

  // Läd alle Tasks in _items
  Future<void> loadTasks();

  // Gibt die Items zurück.
  Future<List<String>> getItems();

  // Fügt ein neues Item hinzu.
  Future<void> addItem(String item);

  // Speichert Items
  Future<void> saveItems(List<String> tasks);

  // Löscht ein Item an einem bestimmten Index.
  Future<void> deleteItem(int index);

  // Aktualisiert ein Item an einem bestimmten Index.
  Future<void> editItem(int index, String newItem);
}
