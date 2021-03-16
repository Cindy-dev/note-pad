import 'package:flutter/material.dart';
import 'package:note_app/provider/note.dart';
import 'package:note_app/screens/note_detail_screen.dart';
import 'package:provider/provider.dart';
import './screens/note_display_screen.dart';
import 'screens/note_input_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context) => Note(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: NoteDisplayScreen(),
        routes: {
         NoteDisplayScreen.routeName: (ctx) => NoteDisplayScreen(),
         NoteInputScreen.routeName: (ctx) => NoteInputScreen(),
         NoteDetailScreen.routeName: (ctx) => NoteDetailScreen(),
        },
        //home:
      ),
    );
  }
}




