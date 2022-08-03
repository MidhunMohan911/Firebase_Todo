import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/Model/todo_model.dart';
import 'package:todo_firebase/Provider/controller.dart';
import 'package:todo_firebase/Screens/Widgets/todowidget.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;
    return todos.isEmpty
        ? const Center(
            child: Text('No Todos..', style: TextStyle(fontSize: 20)),
          )
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoWidget(todo: todo);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: todos.length);
  }
}
