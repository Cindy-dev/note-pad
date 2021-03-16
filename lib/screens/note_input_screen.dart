import 'package:flutter/material.dart';
import 'package:note_app/screens/note_display_screen.dart';
import 'package:provider/provider.dart';
import '../provider/note.dart';
import 'note_detail_screen.dart';

class NoteInputScreen extends StatefulWidget {
  static const routeName = 'note-input';

  @override
  _NoteInputScreenState createState() => _NoteInputScreenState();
}

class _NoteInputScreenState extends State<NoteInputScreen> {
 @override
   void didChangeDependencies() {
      final provider = Provider.of<Note>(context, listen: false);
     if(provider.isInit){
        final noteId = ModalRoute.of(context).settings.arguments as String;
        if(noteId != null){
      provider.editedNote = provider.findById(noteId);
      provider.initValues = {
      'title': provider.editedNote.title,
      'note': provider.editedNote.note,
      };
      provider.noteController.text = provider.editedNote.note;
      }
    }
    provider.isInit = false;
    super.didChangeDependencies();
     }
  @override
  Widget build(BuildContext context) {
     final provider = Provider.of<Note>(context, listen: false);
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
                        onPressed:()=> Navigator.of(context)
                          .popAndPushNamed(NoteDisplayScreen.routeName)),
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
              Padding( 
                padding: const EdgeInsets.fromLTRB(15, 15, 10, 0),
                child: TextFormField(
                  controller: provider.titleController,
                 //initialValue: provider.initValues['title'],
                  //maxLength: 400,
                  scrollPadding: EdgeInsets.all(20),
                  cursorHeight: 20,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 20)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                child: TextFormField(
                  controller: provider.noteController,
                 //initialValue: provider.initValues['note'],
                  // maxLength: 400,
                  maxLines: 400,
                  scrollPadding: EdgeInsets.all(20),
                  cursorHeight: 20,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Note',
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
