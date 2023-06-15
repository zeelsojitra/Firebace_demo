import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebace_demo/cons.dart';
import 'package:flutter/material.dart';

import 'Email Authentication/login_screen.dart';

class Notescreen extends StatefulWidget {
  const Notescreen({Key? key}) : super(key: key);

  @override
  State<Notescreen> createState() => _NotescreenState();
}

class _NotescreenState extends State<Notescreen> {
  final globalkey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login_Screen(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Column(
                children: [
                  Text("Add Notes"),
                  TextFormField(
                    controller: title,
                    decoration: InputDecoration(
                      hintText: "Title",
                    ),
                  ),
                  TextFormField(
                    controller: content,
                    decoration: InputDecoration(
                      hintText: "Content",
                    ),
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.red,
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(wfirebaseAuth.currentUser!.uid)
                        .collection('notes')
                        .add({
                      "noteTitle": title.text,
                      "noteContent": content.text,
                      "createdDate": "${DateTime.now()}",
                    });
                    Navigator.pop(context);
                    title.clear();
                    content.clear();
                  },
                  color: Colors.green,
                  child: Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(wfirebaseAuth.currentUser!.uid)
            .collection('notes')
            .orderBy("createdDate", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done ||
              snapshot.hasData) {
            List<DocumentSnapshot> notes = snapshot.data!.docs;
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  notes[index].get("noteTitle"),
                ),
                subtitle: Text(
                  notes[index].get("noteContent"),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        // edit button ma text pela thi print kerva mate.
                        title = TextEditingController(
                            text: notes[index].get("noteTitle"));
                        content = TextEditingController(
                            text: notes[index].get("noteContent"));
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Column(
                              children: [
                                Text("Update Notes"),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Title";
                                    }
                                  },
                                  controller: title,
                                  decoration: InputDecoration(
                                    hintText: "Title",
                                  ),
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Title";
                                    }
                                  },
                                  controller: content,
                                  decoration: InputDecoration(
                                    hintText: "Content",
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              MaterialButton(
                                onPressed: () {},
                                color: Colors.red,
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  if (globalkey.currentState!.validate()) {
                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(wfirebaseAuth.currentUser!.uid)
                                        .collection('notes')
                                        .doc(notes[index].id)
                                        .update({
                                      "noteTitle": title.text,
                                      "noteContent": content.text,
                                    });
                                    Navigator.pop(context);
                                  }
                                },
                                color: Colors.green,
                                child: Text(
                                  "Update",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        // edit button ma text pela thi print kerva mate.
                        title = TextEditingController(
                            text: notes[index].get("noteTitle"));
                        content = TextEditingController(
                            text: notes[index].get("noteContent"));
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Column(
                              children: [
                                Text("Do you want to delete the notes.?"),
                              ],
                            ),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                color: Colors.red,
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(wfirebaseAuth.currentUser!.uid)
                                      .collection('notes')
                                      .doc(notes[index].id)
                                      .delete();
                                  Navigator.pop(context);
                                  title.clear();
                                  content.clear();
                                },
                                color: Colors.green,
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
