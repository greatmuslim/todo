import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'models/item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SQLite CRUD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ItemListScreen(),
    );
  }
}

class ItemListScreen extends StatefulWidget {
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final DBHelper dbHelper = DBHelper();
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    final fetchedItems = await dbHelper.getItems();
    setState(() {
      items = fetchedItems;
    });
  }

  void _addItem() async {
    final newItem = Item(name: 'New Item', description: 'Item description');
    await dbHelper.insertItem(newItem);
    _fetchItems();
  }

  void _updateItem(Item item) async {
    final updatedItem = Item(id: item.id, name: 'Updated Item', description: 'Updated description');
    await dbHelper.updateItem(updatedItem);
    _fetchItems();
  }

  void _deleteItem(int id) async {
    await dbHelper.deleteItem(id);
    _fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter SQLite CRUD'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text(item.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _updateItem(item),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteItem(item.id!),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
    );
  }
}
