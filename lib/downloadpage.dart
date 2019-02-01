import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'themes.dart' as themes;
import 'dart:collection';
import 'package:flushbar/flushbar.dart';


class downscreen extends StatefulWidget {
  String sub;
  downscreen({
    this.sub
  });
  @override
  _downscreenState createState() => new _downscreenState();
}

class _downscreenState extends State<downscreen>  with TickerProviderStateMixin{
  Animation<double> animation;
  AnimationController _controller;


  LinkedHashMap<dynamic,dynamic> x;
  Iterable<dynamic> y;
  List<String> items=new List();

  bool loaded=false;



  @override
  void initState() {
    super.initState();
    _controller=AnimationController(vsync: this,duration: Duration(milliseconds: 2000));
    _controller.repeat();
  }

  Future _test2() async{
    print('test2');
    FirebaseDatabase database2 = new FirebaseDatabase();
    DatabaseReference _userRef2 = database2.reference().child('FileInformation')
        .child('3rd Year').child('SEM VI').child(widget.sub);

    DataSnapshot snapshot2=await _userRef2.once();
    x=snapshot2.value;
    y=x.keys;
    //print(y.elementAt(0));
    for(int i=0;i<y.length;i++) {
      print(y.elementAt(i));
      items.add(y.elementAt(i));
    }
  }

  Widget _list(){
    _test2().then((onValue){
      if(loaded==false) {
        setState(() {
          loaded=true;
        });
      }
    });
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          trailing: IconButton(icon: Icon(Icons.file_download), onPressed: (){
            print(index);
          }),
          title: Text('${items[index]}'),
        );
      },
    );

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
          title: Text(widget.sub),
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
        body:Center(
          child: _list(),
        )
      ),
    );
  }
}