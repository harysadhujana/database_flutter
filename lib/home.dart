import 'package:flutter/material.dart';
// change `flutter_database` to whatever your project name is
import 'package:flutter_database/database_helper.dart';
import 'package:flutter_database/login.dart';

class MyHomePage extends StatelessWidget {

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home , color: Colors.brown),
        title: Text('SQFlite - Hary Sadhujana'),
        actions: <Widget>[
                IconButton(icon: Icon(Icons.backspace),
                onPressed: (){
                Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => Login()),
                );}
                 )],
      ),
      
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              ClipRRect(
                //borderRadius: BorderRadius.circular(200.0),
                child: Image.asset(
                  'assets/hary.JPG',
                  width: 400.0,
                  height: 400.0,
                  fit: BoxFit.cover,
                ),
              ),
            RaisedButton(
              padding: EdgeInsets.all(10.0),
              color: Colors.pink,
              child: Text('Insert', style: TextStyle(fontSize: 20),),
              onPressed: () {_insert();},
            ),
            RaisedButton(
              padding: EdgeInsets.all(5.0),
              color: Colors.grey,
              child: Text('Query', style: TextStyle(fontSize: 20),),
              onPressed: () {_query();},
            ),
            RaisedButton(
              padding: EdgeInsets.all(5.0),
              color: Colors.orange,
              child: Text('Update', style: TextStyle(fontSize: 20),),
              onPressed: () {_update();},
            ),
            RaisedButton(
              padding: EdgeInsets.all(5.0),
              color: Colors.lightBlueAccent,
              child: Text('Delete', style: TextStyle(fontSize: 20),),
              onPressed: () {_delete();},
            ),
          ],
        ),
      ),
    );
  }
  
  // Button onPressed methods
  
  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : 'Bob',
      DatabaseHelper.columnAge  : 23
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnName : 'Mary',
      DatabaseHelper.columnAge  : 32
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
}