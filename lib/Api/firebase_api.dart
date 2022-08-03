import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_firebase/Model/todo_model.dart';
import 'package:todo_firebase/utils.dart';

class FirebaseApi {
  static Future<String> createTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc();

    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());

    return docTodo.id;
  }

  Stream<List<Todo>> readTodo() => FirebaseFirestore.instance
      .collection('todo')
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => Todo.fromJson(doc.data())).toList());

  static Future updateTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.delete();
  }
}
