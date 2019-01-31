import 'package:flutter/material.dart';
import 'themes.dart' as themes;
import 'package:shared_preferences/shared_preferences.dart';

class settings extends StatefulWidget {
  @override
  _settings createState() => _settings();
}

class _settings extends State<settings> {
  SharedPreferences _prefs;
  static const String colorprefs = "colorprefs";
  static const String mail = "mail";
  static const String down = "down";
  static const String email = "email";

  String helper;

  String tempmail;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance()
      ..then((prefs) {
        setState(() {
          this._prefs = prefs;
        });
      });
    helper=themes.email;
    tempmail=themes.email;
  }

  int _counter = 0;
  static bool _mail = false;
  static bool _down = false;
  //static String _color = "Brown";
  String name;

  static const menuItems = <String>['Brown', 'Red', 'Yellow', 'Pink', 'Orange'];

  static final List<DropdownMenuItem<String>> _dropDownMenu = menuItems
      .map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();

  Future<Null> _setColorPrefs(String val) async {
    await this._prefs.setString(colorprefs, val);
  }

  Future<Null> _setEmailPrefs(String val) async {
    themes.email=val;
    await this._prefs.setString(email, val);
  }

  Future<Null> _setMailPrefs(bool val) async {
    await this._prefs.setBool(mail, val);
  }

  Future<Null> _setDownPrefs(bool val) async {
    await this._prefs.setBool(down, val);
  }

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: themes.themeChoser(themes.color),
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
            Container(
              margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
              padding: EdgeInsets.all(20),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email Address:",helperText: "Saved : $helper"),
                onChanged: (String val) {
                  if(val!=null)
                  tempmail = val;
                },
              ),
            ),
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
                          value: themes.mail,
                          onChanged: (bool value) {
                            setState(() {
                              themes.mail = value;
                            });
                          },
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
                          value: themes.down,
                          onChanged: (bool value) {
                            setState(() {
                              themes.down = value;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: OutlineButton(
                          child: Text('Save'),
                          onPressed: () {
                            this._setColorPrefs(themes.color);
                            this._setDownPrefs(themes.down);
                            this._setMailPrefs(themes.mail);
                            this._setEmailPrefs(tempmail);
                            Navigator.pop(context);
                          })),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    padding: EdgeInsets.all(20),
                    child: ListTile(
                      title: Text("Select Theme"),
                      trailing: DropdownButton(
                          value: themes.color,
                          items: _dropDownMenu,
                          onChanged: (String value) {
                            setState(() {
                              themes.color = value;
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
