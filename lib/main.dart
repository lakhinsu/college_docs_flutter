import 'package:flutter/material.dart';
import 'settings.dart';
import 'themes.dart' as themes;
import 'downloads.dart';
import 'upload.dart';
import 'dart:collection';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'downloadpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'College Docs Flutter',
      theme: ThemeData.dark(),
      routes:{
        '/downloads':(Context)=>downloads(),
        '/uploads':(Context)=>uploads(),
        '/settings': (context) => settings(),
        '/downpage':(Context) =>downscreen(),

      },
      home: MyHomePage(title: 'College Docs Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  int _counter = 0;
  static bool _mail = false;
  static bool _down = false;
  static bool _night = false;
  String name;

  bool loaded=false;

  SharedPreferences _prefs;
  static const String colorprefs="colorprefs";
  static const String mail="mail";
  static const String down="down";
  static const String email = "email";

 Animation<double> animation;
 AnimationController _controller;

  LinkedHashMap<dynamic,dynamic> x;
  Iterable<dynamic> y;

  List<String> items=new List();

  @override
  void initState() {
    super.initState();
    _controller=AnimationController(vsync: this,duration: Duration(milliseconds: 2000));
    _controller.repeat();
    /*SharedPreferences.getInstance() ..then((prefs){
      setState(() {
        this._prefs=prefs;
        _loadPrefs();
      });
    });*/
    _test();
  }
  void _test() async{
    _prefs=await SharedPreferences.getInstance();
    _loadPrefs();
  }

   Future _test2() async{
    print('test2');
    FirebaseDatabase database2 = new FirebaseDatabase();
    DatabaseReference _userRef2 = database2.reference().child('FileInformation')
        .child('3rd Year').child('SEM VI').child("AdJava");

    DataSnapshot snapshot2=await _userRef2.once();
    x=snapshot2.value;
    y=x.keys;
    //print(y.elementAt(0));
    for(int i=0;i<y.length;i++) {
      print(y.elementAt(i));
      items.add(y.elementAt(i));
    }
  }

  void _loadPrefs(){
    setState(() {
      themes.color=this._prefs.getString(colorprefs);
      name=themes.color;
      themes.mail=this._prefs.getBool(mail);
      themes.down=this._prefs.getBool(down);
      themes.email=this._prefs.getString(email);
    });
  }


  void _changeMode() {
    if (themes.isNight) {
      themes.isNight = false;
    } else
      themes.isNight=true;
    setState(() {});
  }


  static const drawerheader = UserAccountsDrawerHeader(
    accountName: Text("College Docs"),
    accountEmail: Text("www.github.com/lakhinsu/college_docs3"),
    currentAccountPicture: CircleAvatar(
        child: FlutterLogo(size: 42), backgroundColor: Colors.white),
  );

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
      data:themes.themeChoser(themes.color),
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
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
        drawer:Drawer(
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                drawerheader,
                ListTile(
                  title: Text('Upload'),
                  leading: Icon(Icons.cloud_upload),
                  onTap: (){
                    Navigator.pushNamed(context,'/uploads');
                  },
                ),
                new Divider(),
                ListTile(
                  leading: Icon(Icons.cloud_download),
                  title: Text(
                    'Downloads',
                  ),
                  onTap: (){
                    Navigator.pushNamed(context,'/downloads');
                  },
                ),
                new Divider(),
                ListTile(
                  leading: Icon(Icons.brightness_2),
                  title: Text('Night Mode'),
                  trailing: Switch(
                    value: themes.isNight,
                    onChanged: (bool value) {
                      _changeMode();
                    },
                  ),
                ),
                new Divider(),
              ],
            )),
        body:Column(
          children: <Widget>[
            Expanded(
            child:Row(
              children: <Widget>[
                Expanded(
                child:Container(
                  height:400,
                 padding: EdgeInsets.all(30),
                  child: Card(
                      color:themes.cardColor(),
                      child:FlatButton(onPressed: (){
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (__) => new downscreen(sub:"AdJava")));
                      }, child: Text("Java"))),
                ),),
                Expanded(
                  flex: 1,
                child:Container(
                  height:400,
                  padding: EdgeInsets.all(30),
                  child: Card(
                      color:themes.cardColor(),
                      child:FlatButton(onPressed: (){
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (__) => new downscreen(sub:"WebTech")));
                      }, child: Text("Web"))),
                ),),
              ],
            ),
            ),
            Expanded(
              flex: 1,
              child:Row(
                children: <Widget>[
                  Expanded(
                    child:Container(
                      height:400,
                      padding: EdgeInsets.all(30),
                      child: Card(
                          color:themes.cardColor(),
                          child:FlatButton(onPressed: (){
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (__) => new downscreen(sub:"SE")));
                          }, child: Text("SE"))),
                    ),),
                  Expanded(
                    flex: 1,
                    child:Container(
                      height:400,
                      padding: EdgeInsets.all(30),
                      child: Card(
                          color:themes.cardColor(),
                          child:FlatButton(onPressed: (){
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (__) => new downscreen(sub:"DataComp")));
                          }, child: Text("DCDR"))),
                    ),),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child:Row(
                children: <Widget>[
                  Expanded(
                    child:Container(
                      height:400,
                      padding: EdgeInsets.all(30),
                      child: Card(
                          color:themes.cardColor(),
                          child:FlatButton(onPressed: (){
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (__) => new downscreen(sub:"DOS")));
                          }, child: Text("DOS"))),
                    ),),
                  Expanded(
                    flex: 1,
                    child:Container(
                      height:400,
                      padding: EdgeInsets.all(30),
                      child: Card(
                          color:themes.cardColor(),
                          child:FlatButton(onPressed: (){
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (__) => new downscreen(sub:"DotNet")));
                          }, child: Text(".Net"))),
                    ),),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}

