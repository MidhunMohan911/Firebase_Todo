import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/Model/todo_model.dart';
import 'package:todo_firebase/Provider/controller.dart';
import 'package:todo_firebase/Screens/Widgets/todoform.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({Key? key}) : super(key: key);

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String discription = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add todo',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            TodoForm(
              onChangeTitle: (title) => setState(() {
                this.title = title;
              }),
              onChangeDiscription: (discription) => setState(() {
                this.discription = discription;
              }),
              onSavedTodo: addTodo,
            )
          ],
        ),
      ),
    );
  }

  void addTodo() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final todo = Todo(
          id: DateTime.now().toString(),
          createdTime: DateTime.now(),
          title: title,
          discription: discription);
      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.addTodo(todo);
      Navigator.of(context).pop();
    }
  }
}
