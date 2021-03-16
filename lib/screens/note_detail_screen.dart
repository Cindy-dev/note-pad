import 'package:flutter/material.dart';
import 'package:note_app/provider/note.dart';
import 'package:note_app/screens/note_display_screen.dart';
import 'package:provider/provider.dart';

import 'note_input_screen.dart';

class NoteDetailScreen extends StatefulWidget {
  static const routeName = 'note-detail';
  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Note>(context, listen: false);
    final id = ModalRoute.of(context).settings.arguments;
    final selectedNote = provider.findById(id);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.brown.shade600,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.grey,
                        size: 30,
                      ),
                      onPressed: () => Navigator.of(context)
                          .popAndPushNamed(NoteDisplayScreen.routeName),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          provider.deleteNote(id);
                          Navigator.of(context)
                              .popAndPushNamed(NoteDisplayScreen.routeName);
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: IconButton(
                        icon: Icon(
                          Icons.save,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          provider.saveNote();
                          Navigator.of(context).pushReplacementNamed(
                              NoteDisplayScreen.routeName);
                        }),
                  )
                ],
              ),
              GestureDetector(
                onTap: ()=>Navigator.of(context).pushNamed(NoteInputScreen.routeName, arguments: id),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 10, 0),
                      child: Text(selectedNote.title),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                      child: Text(selectedNote.note),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
