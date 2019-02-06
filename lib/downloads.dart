import 'package:flutter/material.dart';
import 'themes.dart' as themes;
class downloads extends StatefulWidget {


  @override
  _downloads createState() =>_downloads();
}
class _downloads extends State<downloads> with TickerProviderStateMixin {

  Animation<double> animation;
  AnimationController _controller;
List<String> files;

  @override
  void initState() {
    super.initState();
    _controller=AnimationController(vsync: this,duration: Duration(milliseconds: 2000));
    _controller.repeat();
  
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data:themes.themeChoser(themes.color),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
              Navigator.pop(context);
            }),
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text("Downloads"),
            actions: <Widget>[
              RotationTransition(
              child:IconButton(
                icon: Icon(Icons.settings),
                onPressed: (){Navigator.pushNamed(context,'/settings');},
              ),
                turns: _controller,
              )
            ],

          ),
          body:Center(child:Text("Coming Soon"),),
        )
    );
  }
}