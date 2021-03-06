import 'dart:async';
import 'package:flutter/material.dart';
import 'package:powerlog/service/db_helper.dart';
import 'package:powerlog/model/notes.dart';
import 'package:powerlog/ui/note_detail.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:powerlog/utils/widgets.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;
  int axisCount = 2;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        
        title: Text(
          'Notes',
          style: TextStyle(
              fontFamily: 'Sans',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              axisCount == 2 ? Icons.list : Icons.grid_on,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                axisCount = axisCount == 2 ? 4 : 2;
              });
            },
          )
        ],
      ),
      body: noteList.length == 0
          ? Container(
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Click on the add button to add a new note!',
                    style: TextStyle(
                        fontFamily: 'Sans',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                ),
              ),
            )
          : getNotesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Note('', '', 3, 0), 'Add Note');
        },
        tooltip: 'Add Note',
        child: Icon(
          Icons.add,
          color: Color.fromRGBO(58, 66, 86, 1.0),
          size: 35.0,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget getNotesList() {
    return StaggeredGridView.countBuilder(
      physics: BouncingScrollPhysics(),
      crossAxisCount: 4,
      itemCount: count,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () {
              navigateToDetail(this.noteList[index], 'Edit Note');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: colors[this.noteList[index].color],
                    border: Border.all(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              this.noteList[index].title,
                              style: TextStyle(
                                  fontFamily: 'Sans',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        Text(
                          getPriorityText(this.noteList[index].priority),
                          style: TextStyle(
                              color: getPriorityColor(
                                  this.noteList[index].priority)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              this.noteList[index].description == null
                                  ? ''
                                  : this.noteList[index].description,
                              style: TextStyle(
                                  fontFamily: 'Sans',
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            this.noteList[index].date,
                            style: TextStyle(
                                fontFamily: 'Sans',
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontSize: 14),
                          ),
                        ])
                  ],
                ),
              ),
            ),
          ),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(axisCount),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  // Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      case 3:
        return Colors.green;
        break;

      default:
        return Colors.yellow;
    }
  }

  // Returns the priority icon
  String getPriorityText(int priority) {
    switch (priority) {
      case 1:
        return '!!!';
        break;
      case 2:
        return '!!';
        break;
      case 3:
        return '!';
        break;

      default:
        return '!';
    }
  }


  void navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => NoteDetail(note, title)));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
