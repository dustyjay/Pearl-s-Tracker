import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import './storage.dart';
import './reminder.dart' as reminder;

import 'package:url_launcher/url_launcher.dart';


class Settings extends StatefulWidget{
  final Storage storage;
  Settings({Key key,this.storage}):super(key: key);
  @override
  State createState() => new SettingsState();
}

class SettingsState extends State<Settings>{
  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  String _fileContent;
  String mailresult;

  TextEditingController _emailcontroller = new TextEditingController();
  TextEditingController _messagecontroller = new TextEditingController();

  final _bottomSheet = new GlobalKey<ScaffoldState>();
  VoidCallback _showPersBottomSheetCallBack;

  @override
  void initState(){
    super.initState();
    widget.storage.readData().then((String content){
      _fileContent = content;
    });
  }

  void _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  String _sendmail(String email,String message){
    var sent = false;
    var error;
    var options = new GmailSmtpOptions()
    ..username = 'jarish001@gmail.com'
    ..password = 'klutzers'; 
    
      var emailTransport = new SmtpTransport(options);

      // Create our mail/envelope.
      var envelope = new Envelope()
        ..from = email
        ..subject = 'Request for a new feature'
        ..text = 'Testing email';

      // Email it.
      emailTransport.send(envelope)
        .then((envelope) => sent = true)
        .catchError((e) => error = e);

      if(sent == true) return "Your mail was sent successfully!";
      else return "Sending Failed! Error: $error";
  }
  


  TextStyle _link = new TextStyle(
    fontSize: 24.0
  );

  void _snackBar(String value){
      _scaffold.currentState.showSnackBar(new SnackBar(
        content: new Text(value, style: new TextStyle(color: Colors.white),textAlign: TextAlign.center,),
        backgroundColor: Colors.pink[200],
      ));
    }
  
  void _showAlert(String alert){
    AlertDialog dialog = new AlertDialog(
      title: new Text('Delete All Private Data'),
      content: new Text(alert,
      textAlign: TextAlign.left,
      style: new TextStyle(fontSize: 16.0),),
      actions: <Widget>[
        FlatButton(
          child: new Text('CANCEL'),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        new FlatButton(
          child: new Text('CONTINUE'),
          onPressed: (){
            if(_fileContent == null || _fileContent == ''){
              _snackBar('No data to delete');
            }
            else{
              setState(() {
                widget.storage.writeData([]);
                _snackBar('You now have a clean slate');
              });
            }
            
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, child: dialog);
  }

  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffold,
      resizeToAvoidBottomPadding: false,
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
          // color: Colors.pink[50],
          image: new DecorationImage(
            image: new AssetImage('assets/images/background.png'),
            fit: BoxFit.cover
          )
        ),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              decoration: new BoxDecoration(
                color: Colors.white
              ),
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    leading: new Icon(
                      Icons.person,
                      color: Colors.red,
                      size: 28.0,
                    ),
                    title: new Text('Save Data',style: _link),
                    onTap: (){
                      if(_fileContent == '' || _fileContent == null) _snackBar('No data has been set.');
                      else _snackBar('Your details have been saved successfully!');
                    },
                  ),
                  new Divider(),
                  new ListTile(
                    dense: true,
                    leading: new Icon(
                      Icons.share,
                      color: Colors.blue,
                      size: 28.0,
                    ),
                    title: new Text('Share with friends',style: _link),
                    onTap: (){
                      _showBottomSheet();
                    },
                  ),
                  new Divider(),
                  new ListTile(
                    leading: new Icon(
                      Icons.calendar_today,
                      color: Colors.green,
                      size: 28.0,
                    ),
                    title: new Text('Reminder',style: _link),
                    onTap: (){
                      Navigator.push(context, 
                        new MaterialPageRoute(
                          builder: (context) => new reminder.Reminder(storage: Storage())
                        ));
                    },
                  ),
                  new Divider(),
                  new ListTile(
                    leading: new Icon(
                      Icons.apps,
                      color: Colors.purple,
                      size: 28.0,
                    ),
                    title: new Text('See other apps',style: _link),
                  ),
                  new Divider(),
                  new ListTile(
                    leading: new Icon(
                      Icons.edit,
                      color: Colors.orange,
                      size: 28.0,
                    ),
                    title: new Text('Request a new feature',style: _link),
                    onTap: (){
                      _requestAlert();
                      // _snackBar(mailresult);
                    }
                  ),
                  new Divider(),
                  new ListTile(
                    leading: new Icon(
                      Icons.delete,
                      color: Colors.teal,
                      size: 28.0,
                    ),
                    title: new Text('Delete private data',style: _link),
                    onTap: (){
                      _showAlert('Delete all private data about your cycle. This cannot be undone');
                    },
                  ),
                ],
              )
            )
          ],
           
        ),
      )
    );
  }
  void _requestAlert(){
    bool isReady = false;
    SimpleDialog dialog = new SimpleDialog(
      
      title: new Row(
        children: <Widget>[
          new Image(
            image: new AssetImage('assets/images/logo.png'),
            width: 30.0,
            height: 30.0,
            
          ),
          new Container(
            padding: const EdgeInsets.only(left: 10.0),
            child: new Text('Request new feature'),
          )
        ],
      ),
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.all(5.0),
                decoration: new BoxDecoration(
                  border: new Border(bottom: new BorderSide(width: 1.0,color: Colors.grey))
                ),
                margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
                child: new TextField(
                  controller: _emailcontroller,
                  decoration: new InputDecoration.collapsed(
                    hintText: 'you@example.com'
                  )
                )
              ),
              new Container(
                padding: const EdgeInsets.all(5.0),
                decoration: new BoxDecoration(
                  border: new Border.all(width: 1.0,color: Colors.grey)
                ),
                child: new TextField(
                  controller: _messagecontroller,
                  decoration: new InputDecoration.collapsed(
                    hintText: 'Your message'
                  ),
                  maxLines: 5,
                ),
              )
            ],
          ),
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new FlatButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: new Text('CANCEL',style: new TextStyle(color:Colors.pink[700]),),
            ),
            new FlatButton(
              onPressed: (){
                if (_emailcontroller.text == "" || _messagecontroller.text == ''){
                  Navigator.pop(context);
                  _requestNoMsg('Enter email address/mesage');
                }
                else{
                  mailresult = _sendmail(_emailcontroller.text, _messagecontroller.text);
                  _emailcontroller.text = '';
                  _messagecontroller.text = '';
                  Navigator.pop(context);
                  _snackBar(mailresult);
                }
                // Navigator.pop(context);
              },
              child: new Text('CONTINUE',style: new TextStyle(color:Colors.pink[700]),),
            ),
          ],
        )
      ],
    );

    showDialog(context: context, child: dialog);
  }
  void _showBottomSheet() {
    setState(() {
      _showPersBottomSheetCallBack = null;
    });

    _scaffold.currentState.showBottomSheet((context) {
      return new Container(
        height: 250.0,
        // height: MediaQuery.of(context).size.height+200.0,
        color: Colors.white,
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.fromLTRB(50.0, 20.0, 0.0, 30.0),
                child: new Text('Share with',style: new TextStyle(fontSize: 20.0,color: Colors.cyan),),
              ),
              new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    // flex: 1,
                    child: new Container(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: new InkWell(
                        child: new Column(
                          children: <Widget>[
                            new Image(image: new AssetImage('assets/images/whatsapp.png'),width: 50.0,height: 50.0,),
                            new Text('Whatsapp')
                          ],
                        ),
                        onTap: (){
                          Navigator.pop(context);
                        },
                      )
                    ),
                  ),
                  new Expanded(
                    // flex: 1,
                    child: new Container(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: new InkWell(
                        child: new Column(
                          children: <Widget>[
                            new Image(image: new AssetImage('assets/images/messenger.png'),width: 40.0,height: 40.0,),
                            new Text('Messenger')
                          ],
                        ),
                        onTap: (){
                          Navigator.pop(context);
                        },
                      )
                    ),
                  ),
                  new Expanded(
                    // flex: 1,
                    child: new Container(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 30.0, 0.0),
                      child: new InkWell(
                        child: new Column(
                          children: <Widget>[
                            new Image(image: new AssetImage('assets/images/slack.png'),width: 40.0,height: 40.0,),
                            new Text('Slack')
                          ],
                        ),
                        onTap: (){
                          Navigator.pop(context);
                        },
                      )
                    ),
                  ),
                ],
              ),
              new Padding(padding: const EdgeInsets.only(bottom: 20.0),),
              new Row(
                children: <Widget>[
                  new Expanded(
                    // flex: 1,
                    child: new Container(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: new InkWell(
                        child: new Column(
                          children: <Widget>[
                            new Image(image: new AssetImage('assets/images/twitter.png'),width: 50.0,height: 50.0,),
                            new Text('Twitter')
                          ],
                        ),
                        onTap: (){
                          Navigator.pop(context);
                        },
                      )
                    ),
                  ),
                  new Expanded(
                    // flex: 1,
                    child: new Container(
                      // child: new Image(image: new AssetImage('assets/images/messenger.png'),width: 40.0,height: 40.0,),
                    ),
                  ),
                  new Expanded(
                    // flex: 1,
                    child: new Container(
                      // child: new Image(image: new AssetImage('assets/images/slack.png'),width: 50.0,height: 50.0,),
                    ),
                  ),
                ],
              ),
            ],
          )
        ),
      );
    })
        .closed
        .whenComplete(() {
      if (mounted) {
        setState(() {
          _showPersBottomSheetCallBack = _showBottomSheet;
        });
      }
    });
  }
  void _requestNoMsg(String message){
    AlertDialog dialog = new AlertDialog(
      content: new Text(message,
      textAlign: TextAlign.center,
      style: new TextStyle(fontSize: 20.0),),
      actions: <Widget>[
        new FlatButton(
          child: new Text('OK'),
          onPressed: (){
            Navigator.pop(context);
            _requestAlert();

          },
        )
      ],
    );

    showDialog(context: context, child: dialog);
  }

}