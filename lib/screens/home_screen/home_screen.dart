import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo/themes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  renderToDoListUI(theme) {
    return ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: theme.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: theme.primaryColor,
                  blurRadius: 1,
                ),
              ],
            ),
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
                  width: MediaQuery.of(context).size.width / 2,
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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                currentTheme.toggleTheme();
              },
              icon: const Icon(Icons.brightness_4_rounded)),
        ],
      ),
      body: todoList != null
          ? Column(
              children: [
                renderTotalTasksUI(),
                Expanded(
                  child: renderToDoListUI(theme),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
