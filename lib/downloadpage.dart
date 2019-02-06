import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'themes.dart' as themes;
import 'dart:collection';
import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';

class downscreen extends StatefulWidget {
  String sub;

  String perm_result;
  
  downscreen({this.sub});
  @override
  _downscreenState createState() => new _downscreenState();
}

class _downscreenState extends State<downscreen> with TickerProviderStateMixin {

  static const platform = const MethodChannel('com.lakhinsu.collegedocs3/getperm');


  Animation<double> animation;
  AnimationController _controller;
  String letter;
  Directory _downloadsDirectory;

  LinkedHashMap<dynamic, dynamic> x = new LinkedHashMap();
  Iterable<dynamic> y = new Iterable.empty();
  Iterable<dynamic> z = new Iterable.empty();
  List<String> items = new List();
  List<String> urls=new List();

  bool loaded = false;

Future<void> _getPermissions() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getPermissions');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
  }



  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _controller.repeat();

    initDownloadsDirectoryState();

  }

  Flushbar generateError(String msg){
    Flushbar error=Flushbar(
        title: "Error",
        message: msg,
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
          msg,
          style: TextStyle(fontSize: 18.0, color: Colors.red, fontFamily: "ShadowsIntoLightTwo"),
        ),
      );
      return error;
  }

  
  Flushbar showNotice(String msg){
    Flushbar error=Flushbar(
        title: "Email",
        message: msg,
        flushbarPosition: FlushbarPosition.TOP, //Immutable
        reverseAnimationCurve: Curves.decelerate, //Immutable
        forwardAnimationCurve: Curves.elasticOut, //Immutable
        backgroundColor: Colors.white,
        shadowColor: Colors.white70,
        duration: Duration(seconds: 3),
        isDismissible: false,
        icon: Icon(
          Icons.email,
          size:47,
          color: Colors.black,
        ),
        titleText: new Text(
          "Email",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black, fontFamily: "ShadowsIntoLightTwo"),
        ),
        messageText: new Text(
          msg,
          style: TextStyle(fontSize: 18.0, color: Colors.black, fontFamily: "ShadowsIntoLightTwo"),
        ),
      );
      return error;

  }



  Future<void> initDownloadsDirectoryState() async {
    Directory downloadsDirectory;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      _getPermissions();
      downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
    } on Exception {
      print('Could not get the downloads directory');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _downloadsDirectory = downloadsDirectory;
    });
  }

  Future _test2() async {

    

    print('test2');
    FirebaseDatabase database2 = new FirebaseDatabase();
    DatabaseReference _userRef2 = database2
        .reference()
        .child('FileInformation')
        .child('3rd Year')
        .child('SEM VI')
        .child(widget.sub);

    DataSnapshot snapshot2 = await _userRef2.once();
    x = snapshot2.value;
    y = x.keys;
    z= x.values;
    //print(y.elementAt(0));
    if (items.isNotEmpty) {
      items = new List();
    }
    for (int i = 0; i < y.length; i++) {
      print(y.elementAt(i));
      items.add(y.elementAt(i));
      urls.add(z.elementAt(i));
    }
  }

  void _download(int index) async {
    String path = _downloadsDirectory.path;

    Future<Directory> downloadsDirectory =
        DownloadsPathProvider.downloadsDirectory;

    String url=urls.elementAt(index);
    String tempname=items.elementAt(index);
    String fname=tempname.substring(0,tempname.indexOf(':'));
    print("fname="+fname);

    String ext=tempname.substring(tempname.lastIndexOf(':')+1);
    String output=fname+"."+ext;
    if(themes.down){
    final taskId = await FlutterDownloader.enqueue(
      url:url,
      savedDir: _downloadsDirectory.path,
      outPut: output,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true,
      // click on notification to open downloaded file (for Android)
    );
    final tasks = await FlutterDownloader.loadTasks();
    }
    if(themes.mail){
//send mail request
      if(themes.email!=null){
      String upath = url.substring(url.indexOf("%"), url.indexOf("?"));                      
      String token = url.substring(url.lastIndexOf("&"));
      String newurl = upath;
      Flushbar notice=showNotice("Please Check Your Mail After A Delay...");
      notice.show(context);
      String funtrigger = "https://us-central1-collegedocs2.cloudfunctions.net/filemailer/" + "?mail=hinsulak@gmail.com" + "&filename=" + fname + "." + ext + "&pathh=" + newurl + "&altt=media" + "&tokenn=" + token;
      var response = await http.get(funtrigger);
      }
      else{
          Flushbar error=generateError("Please Set Email Address in Settings");
          error.show(context);
      }

    }
    if(themes.down==false && themes.mail==false){
      Flushbar error=generateError("Please Select Either Email or Download in Settings");
      error.show(context);
    }

  }

  CircleAvatar drawAvatar(String file){
    String ext=file.substring(file.lastIndexOf(":")+1);
    return CircleAvatar(backgroundColor: Colors.white,foregroundColor: Colors.black,child: Text(ext),);

  }

  Widget _list() {
    _test2().then((onValue) {
      if (loaded == false) {
        setState(() {
          loaded = true;
        });
      }
    });
    if(loaded){
    return new ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return new Card(
                  color: themes.listColor(),
                  child: new ListTile(
                    leading: drawAvatar('${items[index]}'),
                   trailing: new IconButton(
                icon:new Icon(Icons.file_download),
                onPressed: () {
                  _download(index);
                  print(index);
                }),
            title: Text('${items[index]}'),
          ),
        );
      },
    );
    }
    else{
      return CircularProgressIndicator();
    }
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
            child: _list(),
          )),
    );
  }
}
