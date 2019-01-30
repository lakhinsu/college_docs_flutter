import 'package:flutter/material.dart';
import 'themes.dart' as themes;
class uploads extends StatefulWidget {


  @override
  _uploads createState() =>_uploads();
}
class _uploads extends State<uploads> {


  @override
  Widget build(BuildContext context) {
    return new Theme(
        data:themes.themeChoser(themes.color),
        child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
            Navigator.pop(context);
          }),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Uploads"),
    actions: <Widget>[
    IconButton(
    icon: Icon(Icons.settings),
    onPressed: (){Navigator.pushNamed(context,'/settings');},
    )
    ],

    ),
          body: Center(child: Text("Upload Screen"),),
    )
    );
  }
}