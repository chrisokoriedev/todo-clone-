import 'package:flutter/material.dart';

import 'add_task.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
Future<List<Task>>_taskList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateTaskList();
  }

  _updateTaskList() {
    setState((){
      _taskList Database.instance.getTaskList();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        child: Icon(Icons.add),
        onPressed: () =>
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTask(),
              ),
            ),
      ),
      body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 40.0),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Task',
                      style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '1 0f 10',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            }
            return _buildTask(index);
          }),
    );
  }

  Widget _buildTask(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          ListTile(
            title: Text('Task Title'),
            subtitle: Text('Dec 26 2020 * high'),
            trailing: Checkbox(
              onChanged: (value) {
                print(value);
              },
              activeColor: Theme
                  .of(context)
                  .primaryColor,
              value: true,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
