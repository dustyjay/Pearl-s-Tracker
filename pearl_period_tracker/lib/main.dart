import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './trackperiod.dart' as tracker;
import './ovulation.dart'as ovulate;
import './healthtips.dart' as health;
import './settings.dart' as settings;

import './storage.dart';

void main(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  return runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Pearl\'s Period Tracker',
      theme: new ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: new FirstPage(),
    );
  }
}


class FirstPage extends StatefulWidget {
  // final Storage storage;

  // FirstPage({Key key,this.storage}):super(key: key);
  @override
  _FirstPageState createState() => new _FirstPageState();
}


class _FirstPageState extends State<FirstPage> {
  TextStyle _screenLinks = new TextStyle(
    color: Colors.black,
    fontSize: 24.0
  );

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        iconTheme: new IconThemeData(
          color: Colors.blue
        ),
        centerTitle: true,
        title: new Image(
          image: new AssetImage('assets/images/logo.png'),
        ),
        backgroundColor: Colors.white,
      ),
      body: new Center(
        
        child: new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/images/background.png'),
              fit: BoxFit.cover
            )
          ),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new InkWell(
                onTap: (){
                  Navigator.push(context, 
                  new MaterialPageRoute(
                    builder: (context) => new tracker.Tracker(storage:Storage())
                  ));
                },
                child: new Container(
                  width: 300.0,
                  margin: new EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 10.0),
                  padding: new EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                    color: const Color(0xFF68C5DB),
                    boxShadow: [new BoxShadow(
                      color: Colors.grey[400],
                      blurRadius: 3.0,
                      offset: new Offset(0.0, 2.0),
                      spreadRadius: 2.0
                    )],
                  ),
                  child: new Center(
                    child: new Text('Track my period',style: _screenLinks,textAlign: TextAlign.center),
                  ),
                ),
              ),
              new InkWell(
                child:  new Container(
                  width: 300.0,
                  margin: new EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 10.0),
                  padding: new EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                    color: const Color.fromRGBO(255, 23, 68, 0.5),
                    boxShadow: [new BoxShadow(
                      color: Colors.grey[400],
                      blurRadius: 3.0,
                      offset: new Offset(0.0, 2.0),
                      spreadRadius: 2.0
                    )],
                  ),
                  child: new Text('Ovulation/Fertility',style: _screenLinks,textAlign: TextAlign.center),
                ),
                onTap: (){
                  Navigator.push(context, 
                  new MaterialPageRoute(
                    builder: (context) => new ovulate.Ovulation()
                  ));
                },
              ),
              new InkWell(
                child: new Container(
                  width: 300.0,
                  margin: new EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 10.0),
                  padding: new EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                    color: const Color(0xFF0197F6),
                    boxShadow: [new BoxShadow(
                      color: Colors.grey[400],
                      blurRadius: 3.0,
                      offset: new Offset(0.0, 2.0),
                      spreadRadius: 2.0
                    )],
                  ),
                  child: new Text('Health tips',style: _screenLinks,textAlign: TextAlign.center),
                ),
                onTap: (){
                  Navigator.push(context, 
                  new MaterialPageRoute(
                    builder: (context) => new health.HealthTips()
                  ));
                },
              ),
              new InkWell(
                child: new Container(
                  width: 300.0,
                  margin: new EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 10.0),
                  padding: new EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                    color: const Color(0xFF06D6A0),
                    boxShadow: [new BoxShadow(
                      color: Colors.grey[400],
                      blurRadius: 3.0,
                      offset: new Offset(0.0, 2.0),
                      spreadRadius: 2.0
                    )],
                  ),
                  child: new Text('Settings',style: _screenLinks,textAlign: TextAlign.center),
                ),
                onTap: (){
                  Navigator.push(context, 
                  new MaterialPageRoute(
                    builder: (context) => new settings.Settings(storage: Storage())
                  ));
                },
              )
            ]
          ),
        )
      )
    );
  }
}
