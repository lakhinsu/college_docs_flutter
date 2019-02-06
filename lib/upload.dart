import 'package:flutter/material.dart';
import 'themes.dart' as themes;
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:firebase_database/firebase_database.dart';

class uploads extends StatefulWidget {
  @override
  _uploads createState() => _uploads();
}

class _uploads extends State<uploads> with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController _controller;

  FirebaseStorage storage;

  String _path;
  String _fileName;

  String _ufilename;

  String sub="AdJava";

  bool isUploading=false;

  static const menuItems = <String>['AdJava', 'DOS', 'DataComp', 'DotNet', 'SE','WebTech'];

  static final List<DropdownMenuItem<String>> _dropDownMenu = menuItems
      .map((String value) => DropdownMenuItem<String>(
    value: value,
    child: Text(value),
  ))
      .toList();


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _controller.repeat();

  }

  void _openFileExplorer() async {
    if (true) {
      try {
        _path = await FlutterDocumentPicker.openDocument();
        if(_path!=null){
        }
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }

      if (!mounted) return;

      setState(() {
        _fileName = _path != null ? _path.split('/').last : '...';
      });
    }
  }
  Flushbar drawsnack(){
      Flushbar flush=Flushbar(
        title: "Uploading File",
        message: "Thank you for sharing this file :)",
        flushbarPosition: FlushbarPosition.TOP, //Immutable
        reverseAnimationCurve: Curves.decelerate, //Immutable
        forwardAnimationCurve: Curves.elasticOut, //Immutable
        backgroundColor: Colors.white,
        shadowColor: Colors.white70,
        backgroundGradient: new LinearGradient(colors: [Colors.black45, Colors.black]),
        isDismissible: false,
        icon: Icon(
          Icons.tag_faces,
          size:47,
          color: Colors.white,
        ),
        showProgressIndicator: true,
        progressIndicatorBackgroundColor:Colors.white,
        titleText: new Text(
          "Uploading....",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white, fontFamily: "ShadowsIntoLightTwo"),
        ),
        messageText: new Text(
          "Thank you for Uploading....",
          style: TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: "ShadowsIntoLightTwo"),
        ),
      );
      return flush;

  }
  void _upload() async{
    if(_path==null || _ufilename==null){
      Flushbar error=Flushbar(
        title: "Error",
        message: "Please Enter Filename Or Check If You Have Selected A File",
        flushbarPosition: FlushbarPosition.TOP, //Immutable
        reverseAnimationCurve: Curves.decelerate, //Immutable
        forwardAnimationCurve: Curves.elasticOut, //Immutable
        backgroundColor: Colors.white,
        shadowColor: Colors.white70,
        duration: Duration(seconds: 3),
        isDismissible: false,
        icon: Icon(
          Icons.error,
          size:47,
          color: Colors.red,
        ),
        titleText: new Text(
          "Error",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red, fontFamily: "ShadowsIntoLightTwo"),
        ),
        messageText: new Text(
          "Please Enter Filename Or Check If You Have Selected A File",
          style: TextStyle(fontSize: 18.0, color: Colors.red, fontFamily: "ShadowsIntoLightTwo"),
        ),
      );
      error.show(context);
    }
    else {
      var now = new DateTime.now();
      print(now);
      String date = now.toString().split(' ').elementAt(0);
      print(date);
      String sfilename;
      sfilename = sub + "-" + _ufilename + ":" + date;

      print(sfilename);

      String ext = _fileName.substring(_fileName.lastIndexOf(".") + 1);

      String dvalue = sub + "-" + _ufilename + ":" + date + ":" + ext;

      print(dvalue);

      StorageReference reference = FirebaseStorage.instance.ref().child(
          "Upload").child("3rd Year").child("SEM VI").child(sub).child(
          sfilename);
      File file = new File(_path);
      Flushbar flush = drawsnack();
      //Upload the file to firebase
      StorageUploadTask uploadTask = reference.putFile(file);
      setState(() {
        print('here');
        flush.show(context);
      });

      StorageTaskSnapshot snapshot = await uploadTask.onComplete;
      String url = await reference.getDownloadURL();

      setState(() {
        isUploading = false;
        flush.dismiss();
      });

      FirebaseDatabase database = new FirebaseDatabase();
      DatabaseReference _userRef = database.reference().child('FileInformation')
          .child('3rd Year').child('SEM VI').child(sub)
          .child(dvalue);
      _userRef.set(url);

     /* FirebaseDatabase database2 = new FirebaseDatabase();
      DatabaseReference _userRef2 = database2.reference().child('FileInformation')
          .child('3rd Year').child('SEM VI').child(sub);

      DataSnapshot snapshot2=await _userRef2.once();
      LinkedHashMap<dynamic,dynamic> x=snapshot2.value;
      Iterable<dynamic> y=x.values;
      print(y.elementAt(0));*/


    }


  }

  @override
  Widget build(BuildContext context) {
    return new Theme(
        data: themes.themeChoser(themes.color),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                }),
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text("Uploads"),
            actions: <Widget>[
              RotationTransition(
                child: IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                turns: _controller,
              )
            ],
          ),
          body: SingleChildScrollView(
            physics: PageScrollPhysics(),
                      child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(border: OutlineInputBorder(borderRadius:BorderRadius.circular(5.0)),labelText: "File Name",helperText: "Don't keep blank spaces"),
                      onChanged: (String val) {
                        if(val!=null)
                          _ufilename = val;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0,25,0, 10),
                    padding: EdgeInsets.all(20),
                    child: Card(
                        color: themes.cardColor(),
                        child: ListTile(
                        title: Text("Select Subject"),
                        trailing: DropdownButton(
                            value:sub,
                            items: _dropDownMenu,
                            onChanged: (String value) {
                              setState(() {
                                sub=value;
                                print(_ufilename);
                                print(sub);
                              });
                            }),
                      ),
                    )
                  ),
                  RaisedButton(
                      child: Text("Select"),
                      onPressed: () {
                        _openFileExplorer();
                      }),
                  Container(
                    margin: EdgeInsets.fromLTRB(0,10, 0, 10),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      _path==null?"NO Files Selected":_path,
                    ),
                  ),
                  RaisedButton(
                    child: Text('Upload'),
                    onPressed: (){
                        _upload();
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
