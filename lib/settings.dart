import 'package:flutter/material.dart';
import 'themes.dart' as themes;

class settings extends StatefulWidget {


  @override
  _settings createState() =>_settings();
}
class _settings extends State<settings> {

  int _counter = 0;
  static bool _mail = false;
  static bool _down = false;
  //static String _color = "Brown";
  String name;

  Widget userInput = Container(
    margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
    padding: EdgeInsets.all(20),
    child: TextField(
      decoration: InputDecoration(labelText: "Enter Email"),
    ),
  );

  static const menuItems = <String>[
    'Brown',
    'Red',
    'Yellow',
    'Pink',
    'Orange'
  ];

  static final List<DropdownMenuItem<String>> _dropDownMenu = menuItems
      .map((String value) => DropdownMenuItem<String>(
    value: value,
    child: Text(value),
  ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data:themes.themeChoser(themes.color),
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text("Settings"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            userInput,
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Send Mail:  ',
                          style: TextStyle(fontSize: 24),
                        ),
                        Checkbox(
                          onChanged: (bool value) {},
                          value: _mail,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Download:  ',
                          style: TextStyle(fontSize: 24),
                        ),
                        Checkbox(
                          onChanged: (bool value) {},
                          value: _down,
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child:
                      OutlineButton(child: Text('Save'), onPressed: () {})),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    padding: EdgeInsets.all(20),
                    child: ListTile(
                      title: Text("Select Theme"),
                      trailing: DropdownButton(
                        value: themes.color,
                          items: _dropDownMenu, onChanged: (String value) {
                          setState(() {
                            themes.color=value;
                          });

                      }),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}