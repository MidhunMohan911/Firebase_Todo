import 'package:flutter/material.dart';

class TodoForm extends StatelessWidget {
  final String title;
  final String discription;
  final ValueChanged<String> onChangeTitle;
  final ValueChanged<String> onChangeDiscription;
  final VoidCallback onSavedTodo;

  const TodoForm(
      {Key? key,
      this.title = '',
      this.discription = '',
      required this.onChangeTitle,
      required this.onChangeDiscription,
      required this.onSavedTodo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTile(),
          const SizedBox(height: 8),
          buildDiscription(),
          const SizedBox(height: 32),
          buildButton()
        ],
      ),
    );
  }

  Widget buildTile() => TextFormField(
        initialValue: title,
        onChanged: onChangeTitle,
        validator: (title) {
          if (title!.isEmpty) {
            return 'The title cannot be empty';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Title',
        ),
      );
  Widget buildDiscription() => TextFormField(
        maxLines: 3,
        initialValue: discription,
        onChanged: onChangeDiscription,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Discription',
        ),
      );
  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black)),
            onPressed: onSavedTodo,
            child: const Text('Save')),
      );
}
