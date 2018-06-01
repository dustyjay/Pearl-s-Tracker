import 'package:flutter/material.dart';
import 'package:local_notifications/local_notifications.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'storage.dart';

class Reminder extends StatefulWidget{
  final Storage storage;

  Reminder({Key key,this.storage}):super(key:key);
  @override
  State createState() => new ReminderState();
}

class ReminderState extends State<Reminder>{
  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  DateTime periodDate;
  var periodSlider;
  var ovulateSlider;
  var fertileSlider;
  String _imageUrl = 'https://flutter.io/images/catalog-widget-placeholder.png';
  String _text;
  bool loggingEnabled = false;

  onNotificationClick(String payload) {
    setState(() {
      _text = 'in onNotificationClick with payload: $payload';
    });
  }

  onReplyClick(String payload) {
    setState(() {
      _text = 'in onReplyClick with payload: $payload';
    });
    LocalNotifications.removeNotification(0);
  }

  void removeNotify(String payload) async {
    await LocalNotifications.removeNotification(0);
  }

  static const AndroidNotificationChannel period_reminder = const AndroidNotificationChannel(
      id: 'not1',
      name: 'period_reminder',
      description: 'Grant this app the ability to show notifications',
      importance: AndroidNotificationChannelImportance.HIGH,
      vibratePattern: AndroidVibratePatterns.DEFAULT,
  );

  DateTime now = new DateTime.now();


  @override
  initState() {
    super.initState();
    widget.storage.readData().then((String content){
      List contents;
      String _fileContent;
      if(content == null || content == ''){
        _fileContent = '';
        
        periodSlider = false;
        ovulateSlider = false;
        fertileSlider = false;
      }
      else{
        _fileContent = content;
        contents = _fileContent.split(',');

        periodDate = contents[0];
        periodSlider = contents[1];
        ovulateSlider = contents[2];
        fertileSlider = contents[3];
      }
    });
  }
  bool checkSlider(String value){
    if(value == 'yes') return true;
    return false;
  }
  String backCheckSlider(bool value){
    if(value == true) return 'yes';
    return 'no';
  }

  Widget build(BuildContext context) {

    TextStyle _reminderTop = new TextStyle(
      fontSize: 18.0,
      color: Colors.grey[700]
    );
    TextStyle _reminderBottom = new TextStyle(
      fontSize: 14.0,
      color: Colors.grey[400]
    );


    return new Scaffold(
      key: _scaffold,
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
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage('assets/images/background.png',),
            fit: BoxFit.cover
          )
        ),
        child: new Container(
          margin: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
          decoration: new BoxDecoration(
            color: Colors.white
          ),
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.all(20.0),
                    child: new Text('Active Reminder',style: _reminderBottom,),
                  )
                ],
              ),
              new Container(child: new Divider(height: 2.0,color: Colors.grey[350])),
              new Container(
                padding: const EdgeInsets.all(20.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Container(child: new Text('Period Reminder',style: _reminderTop,)),
                          new Container(child: new Text('Your next period is in 20 days',style: _reminderBottom,),)
                        ],
                      )
                    ),
                    new Container(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new Container(
                            height: 20.0,
                            child: new Switch(
                              value: checkSlider(periodSlider),
                              onChanged: (bool value){
                                setState(() {
                                  periodSlider = backCheckSlider(value);
                                });
                              },
                            )
                          )
                        ],
                      ),
                    )
                  ],
                )
              ),
              new Container(child: new Divider(height: 2.0,color: Colors.grey[350])),
              new Container(
                padding: const EdgeInsets.all(20.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Container(child: new Text('Ovulation Reminder',style: _reminderTop,)),
                          new Container(child: new Text('10 days until ovulation',style: _reminderBottom,),)
                        ],
                      )
                    ),
                    new Container(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new Container(
                            height: 20.0,
                            child: new Switch(
                              value: checkSlider(ovulateSlider),
                              onChanged: (bool value){
                                setState(() {
                                  ovulateSlider = backCheckSlider(value);
                                });
                              },
                            )
                          )
                        ],
                      ),
                    )
                  ],
                )
              ),
              new Container(child: new Divider(height: 2.0,color: Colors.grey[350])),
              new Container(
                padding: const EdgeInsets.all(20.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Container(child: new Text('Fertility Reminder',style: _reminderTop,)),
                          new Container(child: new Text('Your next fertile day - 2 days left',style: _reminderBottom),)
                        ],
                      )
                    ),
                    new Container(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new Container(
                            height: 20.0,
                            child: new Switch(
                              value: checkSlider(fertileSlider),
                              onChanged: (bool value){
                                setState(() {
                                  fertileSlider = backCheckSlider(value);
                                });
                              },
                            )
                          )
                        ],
                      ),
                    )
                  ],
                )
              ),
              new Container(child: new Divider(height: 2.0,color: Colors.grey[350])),
            ]
          ),
        ),
      )
    );
  }
  

  void _showNotification() async{
    await LocalNotifications.createNotification(
      id: 0,
      title: 'Period Alert!',
      content: 'Your period is coming up in 2 days',
      onNotificationClick: new NotificationAction(
        actionText: '', //ignored
        callback: (String payload) {
          setState((){
            _snackBar('woohoo!');
          });
          removeNotify(payload);
        },
        payload: 'payload with anonymous function',
        callbackName: 'anonymousName'
      )
    );
  }

  void _snackBar(String value){
    _scaffold.currentState.showSnackBar(new SnackBar(
      content: new Text(value, style: new TextStyle(color: Colors.white),textAlign: TextAlign.center,),
      backgroundColor: Colors.pink[200],
    ));
  }

}