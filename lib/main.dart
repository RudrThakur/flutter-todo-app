import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'To Do List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var todoList;

  getToDoList() async {
    try {
      var response =
          await Dio().get('https://jsonplaceholder.typicode.com/todos');

      setState(() {
        todoList = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  renderTotalTasksUI() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text('Total Tasks Available: ${todoList.length}'),
    );
  }

  renderToDoListUI() {
    return ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '# ${todoList[index]['id']}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      todoList[index]['title'],
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  todoList[index]['completed'] == true
                      ? const Icon(Icons.check, color: Colors.green, size: 30)
                      : const Icon(Icons.close, color: Colors.red, size: 30),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    getToDoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: todoList != null
          ? Column(
              children: [
                renderTotalTasksUI(),
                Expanded(
                  child: renderToDoListUI(),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
