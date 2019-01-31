import 'package:flutter/material.dart';
import 'settings.dart';
import 'themes.dart' as themes;
import 'downloads.dart';
import 'upload.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  SharedPreferences _prefs;
  static const String colorprefs="colorprefs";
  static const String mail="mail";
  static const String down="down";
  static const String email = "email";

 Animation<double> animation;
 AnimationController _controller;


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
        body:Center(
          child: Text("Main Screen"),
        )
      ),
    );
  }
}

