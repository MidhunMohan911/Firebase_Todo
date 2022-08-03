import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/Model/todo_model.dart';
import 'package:todo_firebase/Provider/controller.dart';
import 'package:todo_firebase/Screens/Widgets/todoform.dart';

class EditPage extends StatefulWidget {
  final Todo todo;
  const EditPage({Key? key, required this.todo}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String discription;
  @override
  void initState() {
    super.initState();
    title = widget.todo.title;
    discription = widget.todo.discription;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Edit Todo'),
          actions: [
            IconButton(
                onPressed: () {
                  final provider =
                      Provider.of<TodosProvider>(context, listen: false);
                  provider.removeTodo(widget.todo);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: TodoForm(
                title: title,
                onChangeTitle: (title) => setState(() {
                      this.title = title;
                    }),
                onChangeDiscription: (discription) => setState(() {
                      this.discription = discription;
                    }),
                onSavedTodo: saveTodo),
          ),
        ),
      );
  void saveTodo() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.updateTodo(widget.todo, title, discription);
      Navigator.pop(context);
    }
  }
}
