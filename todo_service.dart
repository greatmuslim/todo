import '../models/todo.dart';

class TodoService {
  List<Todo> _todos = [];
  final _uuid = Uuid();

  List<Todo> getTodos() {
    return _todos;
  }

  void addTodo(String title, String description) {
    final todo = Todo(
      id: _uuid.v4(),
      title: title,
      description: description,
    );
    _todos.add(todo);
  }

  void updateTodo(String id, String title, String description) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index].title = title;
      _todos[index].description = description;
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
  }
}