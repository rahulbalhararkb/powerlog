import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:powerlog/model/note.dart';
import 'package:powerlog/service/firebase_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:powerlog/ui/add_defect.dart';
import 'package:powerlog/ui/display_defect.dart';

class ListJob extends StatefulWidget {
  final String uid;
  final String list;
  ListJob(this.uid, this.list);

  @override
  _ListJobState createState() => new _ListJobState();
}

class _ListJobState extends State<ListJob> {
  String _value;
  List<Note> items;
  List<Note> filteritems;
  List<Note> filteritemsf;
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
  List<int> _filterListf;

  @override
  void dispose() {
    noteSub?.cancel();
    super.dispose();
  }

 _ListJobState() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Padding(
          padding: const EdgeInsets.only(left: 70.0),
          child: Text(
            'JOB LIST',
            style: TextStyle(color: Colors.white),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
          margin: EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.list == "ALL" ? _createdummyView() : _createSelectionView(),
                _createSearchView(),
                SizedBox(
                  height: 10.0,
                ),
                 _firstSearch ? _selectListView() : _performSearch(),
              
              ],
            ),
          )),
           floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        tooltip: 'Add Job',
        child: Icon(
          Icons.add,
          color: Color.fromRGBO(58, 66, 86, 1.0),
          size: 35.0,
        ),
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
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.0),
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

    Widget _createdummyView() {
    return  Container();
  }

//Create a SelectionView
  Widget _createSelectionView() {
    return new Container(
      padding: EdgeInsets.only(top: 0.0, left: 20.0, right: 5.0),
      child: new StreamBuilder(
          stream: Firestore.instance.collection(widget.list).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            //var length = snapshot.data.documents.length;
            //DocumentSnapshot ds = snapshot.data.documents[length - 1];
            return Center(
              child: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.grey[500],
                ),
                child: DropdownButton(
                  isExpanded: true,
                  hint: Text(
                    'Please choose a ${widget.list}',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ), // Not necessary for Option 1
                  value: _value,
                  onChanged: (newValue) {
                    setState(() {
                      _value = newValue;
                      print(_value);
                    });
                  },
                  items:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return DropdownMenuItem(
                        value: document.documentID,
                        child: Container(
                          child: new Text(
                            document.documentID,
                            style: TextStyle(color: Colors.white),
                          ),
                        ));
                  }).toList(),
                ),
              ),
            );
          }),
    );
  }

  Widget _selectListView() {
    switch (widget.list) {
       case "ALL":
        {
          return _createListView();
        }
        break;
      case "STAGE":
        {
          filteritems = List<Note>();
          _filterList = List<int>();
          for (int i = 0; i < items.length; i++) {
            var item = items[i].stage;

            if (item == _value) {
              filteritems.add(items[i]);
              _filterList.add(i);
            }
          }
          return _createFilteredListView();
        }
        break;

      case "UNIT":
        {
          filteritems = List<Note>();
          _filterList = List<int>();
          for (int i = 0; i < items.length; i++) {
            var item = items[i].unit;

            if (item == _value) {
              filteritems.add(items[i]);
              _filterList.add(i);
            }
          }
          return _createFilteredListView();
        }
        break;
      case "AREA":
        {
          filteritems = List<Note>();
          _filterList = List<int>();
          for (int i = 0; i < items.length; i++) {
            var item = items[i].area;

            if (item == _value) {
              filteritems.add(items[i]);
              _filterList.add(i);
            }
          }
          return _createFilteredListView();
        }
        break;

      case "JOBTYPE":
        {
          filteritems = List<Note>();
          _filterList = List<int>();
          for (int i = 0; i < items.length; i++) {
            var item = items[i].jobtype;

            if (item == _value) {
              filteritems.add(items[i]);
              _filterList.add(i);
            }
          }
          return _createFilteredListView();
        }
        break;
      case "JOBSTATUS":
        {
          filteritems = List<Note>();
          _filterList = List<int>();
          for (int i = 0; i < items.length; i++) {
            var item = items[i].jobstatus;

            if (item == _value) {
              filteritems.add(items[i]);
              _filterList.add(i);
            }
          }
          return _createFilteredListView();
        }
        break;
      default:
        {
          return _createListView();
        }
        break;
    }
  }

//Create a ListView widget
  Widget _createListView() {
    return new Flexible(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: items.length,
          padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
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
                            child: Padding(
                                padding: EdgeInsets.only(left: 5.0, top: 10.0),
                                child: Text(
                                    '${items[position].stage}/${items[position].unit}/${items[position].area}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10.0))),
                          ),
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                child: Text(
                                    '${items[position].jobtype}/${items[position].jobstatus}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10.0))),
                          )
                        ],
                      ),
                      /* leading: '${items[position].uid}' == widget.uid ? 
                               IconButton(icon: const Icon(Icons.remove_circle_outline),onPressed: () => _deleteNote(context, items[_filterList[position]], position))
                               : null,*/
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
    filteritemsf = List<Note>();
    _filterListf = List<int>();
    for (int i = 0; i < items.length; i++) {
      var item = items[i].jobdetails;
      if (item.toLowerCase().contains(_query.toLowerCase())) {
        filteritemsf.add(items[i]);
        _filterListf.add(i);
      }
    }
    return _createFilteredListfView();
  }


//Create the Filtered ListView
  Widget _createFilteredListfView() {
    return new Flexible(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _filterListf.length,
          padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
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
                        '${items[_filterListf[position]].jobdetails}',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(left: 5.0, top: 10.0),
                                child: Text(
                                    '${items[_filterListf[position]].stage}/${items[_filterListf[position]].unit}/${items[_filterListf[position]].area}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10.0))),
                          ),
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                child: Text(
                                    '${items[_filterListf[position]].jobtype}/${items[_filterListf[position]].jobstatus}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10.0))),
                          )
                        ],
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Colors.white, size: 35.0),
                      onTap: () => _navigateToNote(
                          context, items[_filterListf[position]]),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

//Create the Filtered ListView
  Widget _createFilteredListView() {
    return new Flexible(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _filterList.length,
          padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
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
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(left: 5.0, top: 10.0),
                                child: Text(
                                    '${items[_filterList[position]].stage}/${items[_filterList[position]].unit}/${items[_filterList[position]].area}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10.0))),
                          ),
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                child: Text(
                                    '${items[_filterList[position]].jobtype}/${items[_filterList[position]].jobstatus}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10.0))),
                          )
                        ],
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Colors.white, size: 35.0),
                      onTap: () => _navigateToNote(
                          context, items[_filterList[position]]),
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
      MaterialPageRoute(builder: (context) => DisplayDefect(note, widget.uid)),
    );
  }

void _createNewNote(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddDefect(
              widget.uid,
              Note(null, '', '', '', '', '', '', '', '', '', '', 
                  ''))),
    );
  }

}
