import 'package:flutter/material.dart';

import '../util/todo_list.dart';

class HomePage extends StatefulWidget {


  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List _todo = [
    ["Welcome to Cloud List", false],
    ["Click on + to Add a list", false],
    ["Click on Checkbox to mark as Complete", false],
    ["Swipe left to delete", false],
    ["Swipe right to edit", false],
  ];

  final _textController = TextEditingController();

  void onClick() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.yellow[200],
        title: Text("Add a New Task"),
        content: TextField(
          controller: _textController,
          decoration: InputDecoration(
            hintText: "Enter task",
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                _textController.clear();
              },
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => {
              onAdd(_textController),
              Navigator.pop(context)
            },
            child: Text("Add"),
          )
        ],
      )
    );
  }

  void onClickUpdate(int index) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.yellow[200],
          title: Text("Edit Task"),
          content: TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: "Enter task",
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  onUpdate(index);
                },
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                  onUpdate(index);
                  Navigator.pop(context);
              },
              child: Text("Edit"),
            )
          ],
        )
    );
  }

  void onAdd(textController) {
    setState(() {
      _todo.add([textController.text, false]);
    });
  }

  //Update Check
  void onCheck(bool? value, int index) {
    setState(() {
      _todo[index][1] = !_todo[index][1];
    });
  }

  //Delete tile
  void onDelete(int index) {
    setState(() {
      _todo.removeAt(index);
    });
  }

  void onUpdate(int index) {
    setState(() {
      _todo[index][0] = _textController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Background Color
      backgroundColor: Colors.yellow[200],

      //AppBar
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(
          "Cloud List",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),

      //Body
      body: ListView.builder(
        itemCount: _todo.length,
        itemBuilder: (BuildContext context, int index){
          return TodoList(
            checked: _todo[index][1],
            title: _todo[index][0],
            onCheck: (value) => onCheck(value, index),
            onDelete: (context) => onDelete(index),
            onUpdate: (context) => onClickUpdate(index),
          );
        },
      ),

      //Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: onClick,
        backgroundColor: Colors.yellow,
        child: Icon(Icons.add),
      ),
    );
  }
}
