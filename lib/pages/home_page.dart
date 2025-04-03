import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudlist/services/firestore.dart';
import 'package:cloudlist/util/todo_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController textController = TextEditingController();

  FirestoreServices firestoreServices = FirestoreServices();

  void openDialogBox(String? docID) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.yellow[200],

        //Title
        title: Text("Add a Note"),

        //TextField
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: "Enter task",
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                textController.clear();
              },
            ),
          ),
        ),

        //Cancel and Save
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => {
              if (docID != null) {
                firestoreServices.updateNote(docID, textController.text),
              } else
                {
                  firestoreServices.addNote(textController.text, false),
                  textController.clear(),
                },
              Navigator.pop(context)
            },
            child: Text("Add"),
          )
        ],
      )
    );
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
      body: StreamBuilder(
        stream: firestoreServices.getNotesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //Get all docs
            List notes = snapshot.data!.docs;

            //Display in a list
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                
                //Get individual doc
                DocumentSnapshot doc = notes[index];
                String docID = doc.id;

                //Get data from doc
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                String note = data['note'];
                bool check = data['isComplete'];

                //Display
                return TodoList(
                  title: note,
                  checked: check,
                  docID: docID,
                  openDialogBox: openDialogBox,
                );
              }
            );
          } else {
            return const Text("No Notes");
          }
        },
      ),

      //Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialogBox(null);
        },
        backgroundColor: Colors.yellow,
        child: Icon(Icons.add),
      ),
    );
  }
}
