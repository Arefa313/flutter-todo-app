import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Task {
  String title;
  bool isCompleted;

  Task(this.title, this.isCompleted);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> _tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_tasks[index].title),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          // Mark task as completed
                          setState(() {
                            _tasks[index].isCompleted = true;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          // Edit task
                          String editedTask = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Edit Task'),
                                content: TextFormField(
                                  initialValue: _tasks[index].title,
                                  onChanged: (value) {
                                    // Store the edited task text
                                     var editedTask = value;
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Close the dialog
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Update task with edited text
                                      setState(() {
                                        _tasks[index].title = editedTask;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Delete task
                          setState(() {
                            _tasks.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                  // Show a strike-through for completed tasks
                  tileColor: _tasks[index].isCompleted
                      ? Colors.grey[300]
                      : Colors.transparent,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onFieldSubmitted: (value) {
                // Add a new task
                setState(() {
                  _tasks.add(Task(value, false));
                });
              },
              decoration: InputDecoration(
                labelText: 'Add a task',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // Add a new task (alternative way)
                    setState(() {
                      _tasks.add(Task(_tasks.length.toString(), false));
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}