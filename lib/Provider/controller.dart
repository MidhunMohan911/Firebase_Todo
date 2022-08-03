import 'package:flutter/material.dart';
import 'package:todo_firebase/Api/firebase_api.dart';
import 'package:todo_firebase/Model/todo_model.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todo = [];

  void setTodos(List<Todo> todos) =>
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        _todo = todos;
        notifyListeners();
      });

  List<Todo> get todos => _todo.where((todo) => todo.isDone == false).toList();
  List<Todo> get todosCompleted =>
      _todo.where((todo) => todo.isDone == true).toList();

  void addTodo(Todo todo) => FirebaseApi.createTodo(todo);

  void removeTodo(Todo todo) => FirebaseApi.deleteTodo(todo);

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);
    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String discription) {
    todo.title = title;
    todo.discription = discription;

    FirebaseApi.updateTodo(todo);
  }
}
