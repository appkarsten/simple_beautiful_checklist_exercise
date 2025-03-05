import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/features/task_list/widgets/empty_content.dart';
import 'package:simple_beautiful_checklist_exercise/features/task_list/widgets/item_list.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({
    super.key,
    required this.repository,
  });

  final DatabaseRepository repository;

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final List<String> _items = [];
  bool isLoading = true;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.repository.loadTasks();
    _updateList();
  }

  void _updateList() async {
    _items.clear();
    _items.addAll(await widget.repository.getItems());
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meine Checkliste'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: _items.isEmpty
                      ? const EmptyContent()
                      : ItemList(
                          repository: widget.repository,
                          items: _items,
                          updateOnChange: _updateList,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Task Hinzufügen',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () async {
                          if (_controller.text.isNotEmpty) {
                            _items.add(_controller.text);
                            // widget.repository.saveItems([_controller.text]);
                            await widget.repository.saveItems(_items);
                            _controller.clear();
                            _updateList();
                            //setState(() {});
                          }
                        },
                      ),
                    ),
                    onSubmitted: (value) async {
                      if (value.isNotEmpty) {
                        _items.add(_controller.text);
                        await widget.repository.saveItems(_items);
                        _controller.clear();
                        _updateList();
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
