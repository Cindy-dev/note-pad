import 'package:flutter/material.dart';
import '../provider/note.dart';
import 'package:provider/provider.dart';

import 'note_detail_screen.dart';
import 'note_input_screen.dart';

class NoteDisplayScreen extends StatefulWidget {
  static const routeName = 'note-display';
  @override
  _NoteDisplayScreenState createState() => _NoteDisplayScreenState();
}

class _NoteDisplayScreenState extends State<NoteDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Note>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        // key: provider.homeScaffoldKey,
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container( 
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text(
                      'NOTE PAD',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  FutureBuilder(
                    future: provider.fetchAndSetNote(),
                    builder: (ctx, snapShot) => snapShot.connectionState ==
                            ConnectionState.waiting
                        ? Center(
                            heightFactor:
                                MediaQuery.of(context).size.height * 0.025,
                            child: CircularProgressIndicator())
                        : Consumer<Note>(
                            child: Center(
                                heightFactor:
                                    MediaQuery.of(context).size.height * 0.045,
                                child: const Text(
                                  'Opps!! got no notes yet? Start adding some.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                )),
                            builder: (ctx, note, ch) => note.items.length <= 0
                                ? ch
                                : Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: note.items.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (ctx, i) => Card(
                                        shadowColor: Colors.black,
                                        color: Colors.grey.shade400,
                                        elevation: 1,
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(note.items[i].title),
                                          ),
                                          // SizedBox(
                                          //   height: MediaQuery.of(context)
                                          //           .size
                                          //           .height *
                                          //       0.015,
                                          // ),
                                          subtitle: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(note.items[i].note),
                                          ),
                                          onTap: () => Navigator.of(context)
                                              .pushNamed(
                                                  NoteDetailScreen.routeName,
                                                  arguments: note.items[i].id),
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: CircleAvatar(
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(NoteInputScreen.routeName),
          ),
        ),
      ),
    );
  }
}
