import 'package:flutter/material.dart';

class HealthTips extends StatefulWidget{
  @override
  State createState() => new HealthTipsState();
}

class HealthTipsState extends State<HealthTips>{
  TextStyle healthtips = new TextStyle(
    fontSize: 24.0
  );
  TextStyle tips = new TextStyle(
    fontSize: 18.0,
  );
  Widget build(BuildContext context){
    return new Scaffold(
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
          image: new DecorationImage(
            image: new AssetImage('assets/images/background.png'),
            fit: BoxFit.cover
          )
        ),
        child: new Container(
          margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
          decoration: new BoxDecoration(
            color: Colors.white
          ),
          child: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.all(10.0),
                    child: new Text('Health Tips', style: healthtips,textAlign: TextAlign.center,),
                  ),
                ],
              ),
              
              new Container(
                margin: const EdgeInsets.only(bottom: 0.0),
                child: new Divider(height: 1.0,color: Colors.grey)
              ),
              new Expanded(
                child: new ListView(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                  primary: true,
                  shrinkWrap: true,
                  children: <Widget>[
                    new Container(
                      margin: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                      padding: const EdgeInsets.all(15.0),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        boxShadow: [new BoxShadow(
                          color: Colors.grey[400],
                          blurRadius: 3.0,
                          spreadRadius: 2.0,
                          offset: new Offset(0.0, 2.0),
                        )]
                      ),
                      child: new Text('Drink atleast 8 - 10 glasses of water a day to cleanse your body system.', style: tips,),
                    ),
                    new Container(
                      margin: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                      padding: const EdgeInsets.all(15.0),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        boxShadow: [new BoxShadow(
                          color: Colors.grey[400],
                          blurRadius: 3.0,
                          spreadRadius: 2.0,
                          offset: new Offset(0.0, 2.0),
                        )]
                      ),
                      child: new Text('Change your Sanitary pad/towel every 8 hours.', style: tips,),
                    ),
                    new Container(
                      margin: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                      padding: const EdgeInsets.all(15.0),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        boxShadow: [new BoxShadow(
                          color: Colors.grey[400],
                          blurRadius: 3.0,
                          spreadRadius: 2.0,
                          offset: new Offset(0.0, 2.0),
                        )]
                      ),
                      child: new Text('Avoid Processed Junk Food (Eat Real Food Instead)', style: tips,),
                    ),
                    new Container(
                      margin: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                      padding: const EdgeInsets.all(15.0),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        boxShadow: [new BoxShadow(
                          color: Colors.grey[400],
                          blurRadius: 3.0,
                          spreadRadius: 2.0,
                          offset: new Offset(0.0, 2.0),
                        )]
                      ),
                      child: new Text('Don\'t Smoke or do Drugs, and Only Drink in Moderation', style: tips,),
                    ),
                    new Container(
                      margin: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                      padding: const EdgeInsets.all(15.0),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        boxShadow: [new BoxShadow(
                          color: Colors.grey[400],
                          blurRadius: 3.0,
                          spreadRadius: 2.0,
                          offset: new Offset(0.0, 2.0),
                        )]
                      ),
                      child: new Text('Minimize Your Intake of Added Sugars. It can cause Obesity, cancer, diabetes etc.', style: tips,),
                    ),
                    new Container(
                      margin: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
                      padding: const EdgeInsets.all(15.0),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        boxShadow: [new BoxShadow(
                          color: Colors.grey[400],
                          blurRadius: 3.0,
                          spreadRadius: 2.0,
                          offset: new Offset(0.0, 2.0),
                        )]
                      ),
                      child: new Text('Don’t skip breakfast.', style: tips,),
                    ),
                    new Container(
                      margin: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 0.0),
                      padding: const EdgeInsets.all(15.0),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        boxShadow: [new BoxShadow(
                          color: Colors.grey[400],
                          blurRadius: 3.0,
                          spreadRadius: 2.0,
                          offset: new Offset(0.0, 2.0),
                        )]
                      ),
                      child: new Text('Get atleast 8 hours sleep everyday.', style: tips,),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      )
    );
  }
}