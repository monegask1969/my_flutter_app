import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/random_color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo ',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(title: 'For Solid Software'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  RandomColor _randomColor = RandomColor();
  Color color;

  void _randomColorPicker(){
    setState(() {
    color = _randomColor.randomColor();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new Container(child: new DrawerHeader(child: new Container(
                child: IconButton(
                  icon: new Icon(Icons.account_circle),
                  iconSize: 90,
                  onPressed: _randomColorPicker,
                ),

              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ))),
            new Container(
              child: new Column(
                children: <Widget>[
                  new ListTile(
                  leading: new Icon(Icons.person),
                  title: new Text('Profile'),
                  onTap: (){},
                ),
                  new ListTile(
                    leading: new Icon(Icons.brush),
                    title: new Text('Color Picker', style: TextStyle(color: color),),
                    onTap: (){},
                  ),
                  new ListTile(
                    leading: new Icon(Icons.settings),
                    title: new Text('Settings'),
                    onTap: (){},
                  ),
                  new ListTile(
                    leading: new Icon(Icons.supervisor_account),
                    title: new Text('Support'),
                    onTap: (){},
                  )
                ],
              ),
            )
          ],
        ),
    ),
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.message),
              onPressed: (){_asyncConfirmDialog(context);})
        ],
      ),
      backgroundColor: color,
      body:
      Center(
        child: GestureDetector(
          onTap: (){
            setState(() {
              _randomColorPicker();
            });
          },
          child: Text(
            'Hey there',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 60, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: Icon(Icons.add),
        heroTag: "demoValue",
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}

enum ConfirmAction { CANCEL, ACCEPT }
Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Do you have a money?'),
        content: const Text(
            'Remember, that No Money, No Honey.'),
        actions: <Widget>[
          FlatButton(
            child: const Text('Give me your HONEY'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: const Text('Not now'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      );
    },
  );
}
