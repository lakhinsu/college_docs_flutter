import 'package:flutter/material.dart';
import 'themes.dart' as themes;
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter_document_picker/flutter_document_picker.dart';

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
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }

      if (!mounted) return;

      setState(() {
        _fileName = _path != null ? _path.split('/').last : '...';
      });
    }
  }
  void _upload() async{


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
          body: Center(
            child: Column(
              children: <Widget>[
                RaisedButton(
                    child: Text("Select"),
                    onPressed: () {
                      _openFileExplorer();
                    }),
                RaisedButton(
                  child: Text('Upload'),
                  onPressed: (){
                    StorageReference reference = FirebaseStorage.instance.ref().child("test/$_fileName");
                    File file=new File(_path);
                    //Upload the file to firebase
                    StorageUploadTask uploadTask = reference.putFile(file);
                  },
                )
              ],
            ),
          ),
        ));
  }
}
