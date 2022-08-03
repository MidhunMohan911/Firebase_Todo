import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/Api/firebase_api.dart';
import 'package:todo_firebase/Model/todo_model.dart';
import 'package:todo_firebase/Provider/controller.dart';
import 'package:todo_firebase/Screens/Widgets/add_todo.dart';
import 'package:todo_firebase/Screens/Widgets/completed_list.dart';
import 'package:todo_firebase/Screens/Widgets/todolist.dart';
import 'package:todo_firebase/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final tabs = [TodoList(), CompletedList()];

    return Scaffold(
      appBar: AppBar(
        title: Text('TODO APP'),
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white.withOpacity(0.7),
          selectedItemColor: Colors.white,
          currentIndex: selectedIndex,
          onTap: (index) => setState(() {
                selectedIndex = index;
              }),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.fact_check_outlined,
                  size: 28,
                ),
                label: 'Todos'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.done,
                  size: 28,
                ),
                label: 'Completed')
          ]),
      body: StreamBuilder<List<Todo>>(
        stream: FirebaseApi().readTodo(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return const Text('Something Went Wrong Please Try Again Later');
              } else {
                if (snapshot.hasData) {
                  final todos = snapshot.data;
                  final provider = Provider.of<TodosProvider>(context);
                  provider.setTodos(todos!);

                  return tabs[selectedIndex];
                }
              }
          }

          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }

          print(snapshot.data);

          return tabs[selectedIndex];
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.black,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const AddTodoDialog(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
