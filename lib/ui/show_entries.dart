import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:powerlog/model/note.dart';
import 'package:powerlog/service/firebase_firestore_service.dart';
import 'package:powerlog/ui/add_defect.dart';
import 'package:powerlog/ui/display_defect.dart';

//Represents the ShowEntriespage widget
class ShowEntries extends StatefulWidget {
  ShowEntries({Key key, this.title}) : super(key: key);

  final String title;

//`createState()` will create the mutable state for this widget at
//a given location in the tree.
  @override
  _ShowEntriesState createState() => _ShowEntriesState();
}

//Our ShowEntries state, the logic and internal state for a StatefulWidget.
class _ShowEntriesState extends State<ShowEntries> {
  List<Note> items;
  List<Note> filteritems;
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  StreamSubscription<QuerySnapshot> noteSub;

  @override
  void initState() {
    super.initState();

    items = new List();

    noteSub?.cancel();
    noteSub = db.getNoteList().listen((QuerySnapshot snapshot) {
      final List<Note> notes = snapshot.documents
          .map((documentSnapshot) => Note.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = notes;
      });
    });
  }

//A controller for an editable text field.
//Whenever the user modifies a text field with an associated
//TextEditingController, the text field updates value and the
//controller notifies its listeners.
  var _searchview = new TextEditingController();
  bool _firstSearch = true;
  String _query = "";
  List<int> _filterList;

  @override
  void dispose() {
    noteSub?.cancel();
    super.dispose();
  }

  _ShowEntriesState() {
//Register a closure to be called when the object changes.
    _searchview.addListener(() {
      if (_searchview.text.isEmpty) {
//Notify the framework that the internal state of this object has changed.
        setState(() {
          _firstSearch = true;
          _query = "";
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
        });
      }
    });
  }
//Build our ShowEntries widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Padding(
          padding: const EdgeInsets.only(left: 90.0),
          child: Text("Job List"),
        ),
      ),
      body: new Container(
        margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 2.0),
        child: new Column(
          children: <Widget>[
            _createSearchView(),
            SizedBox(height: 10.0,),
            _firstSearch ? _createListView() : _performSearch()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.add,color: Color.fromRGBO(58, 66, 86, 1.0),size: 35.0,),
        onPressed: () => _createNewNote(context),
      ),
    );
  }

//Create a SearchView
  Widget _createSearchView() {
    return new Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 2.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: new TextField(
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 15.0),
          controller: _searchview,
          decoration: InputDecoration.collapsed( 
            hintText: "Search job details",
            hintStyle: new TextStyle(color: Colors.grey[300]),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

//Create a ListView widget
  Widget _createListView() {
    return new Flexible(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: items.length,
          padding: const EdgeInsets.only(left: 5.0,right: 5.0,bottom: 5.0),
          itemBuilder: (context, position) {
            return Card(
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration:
                    BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                child: Column(
                  children: <Widget>[
                    Divider(height: 5.0),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      title: Text(
                        '${items[position].jobdetails}',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Padding(
                                padding: EdgeInsets.only(left: 5.0,top: 10.0),
                                child: Text('${items[position].stage}/${items[position].unit}/${items[position].area}',
                                    style: TextStyle(color: Colors.white,fontSize: 10.0))),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                                padding: EdgeInsets.only(left: 10.0,top: 10.0),
                                child: Text('${items[position].jobtype}/${items[position].jobstatus}',
                                    style: TextStyle(color: Colors.white,fontSize: 10.0))),
                          )
                        ],
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Colors.white, size: 35.0),
                      onTap: () => _navigateToNote(context, items[position]),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

//Perform actual search
  Widget _performSearch() {
    filteritems = List<Note>();
    _filterList = List<int>();
    for (int i = 0; i < items.length; i++) {
      var item = items[i].jobdetails;
      if (item.toLowerCase().contains(_query.toLowerCase())) {
        filteritems.add(items[i]);
        _filterList.add(i);
      }
    }
    return _createFilteredListView();
  }

//Create the Filtered ListView
  Widget _createFilteredListView() {
    return new Flexible(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _filterList.length,
         padding: const EdgeInsets.only(left: 5.0,right: 5.0,bottom: 5.0),
          itemBuilder: (context, position) {
            return Card(
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration:
                    BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                child: Column(
                  children: <Widget>[
                    Divider(height: 5.0),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      title: Text(
                        '${items[_filterList[position]].jobdetails}',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle:Row(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Padding(
                                padding: EdgeInsets.only(left: 5.0,top: 10.0),
                                child: Text('${items[_filterList[position]].stage}/${items[_filterList[position]].unit}/${items[_filterList[position]].area}',
                                    style: TextStyle(color: Colors.white,fontSize: 10.0))),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                                padding: EdgeInsets.only(left: 10.0,top: 10.0),
                                child: Text('${items[_filterList[position]].jobtype}/${items[_filterList[position]].jobstatus}',
                                    style: TextStyle(color: Colors.white,fontSize: 10.0))),
                          )
                        ],
                      ),
                       trailing: Icon(Icons.keyboard_arrow_right,
                          color: Colors.white, size: 35.0),
                      onTap: () =>
                          _navigateToNote(context, items[_filterList[position]]),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void _navigateToNote(BuildContext context, Note note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DisplayDefect(note)),
    );
  }

  void _createNewNote(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddDefect(Note(
              null, '', '', '', '', '', '', '', '', '', '', '', '', '', ''))),
    );
  }
}
