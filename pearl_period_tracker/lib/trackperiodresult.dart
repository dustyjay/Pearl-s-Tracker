import 'package:flutter/material.dart';
import 'dart:math';

class PeriodResult extends StatefulWidget{
  final results;

  PeriodResult({Key key,this.results}): super(key: key);
  @override
  State createState() => new PeriodResultState();
}

class PeriodResultState extends State<PeriodResult>{
  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();

  List results;

  @override
  void initState(){
    super.initState();
    setState(() {
      results = widget.results;
    });
  }


  bool isPickedDay(String day){
    if(day == results[2]) return true;
    return false;
  }


  @override
  Widget build(BuildContext context){
  
    void _snackBar(String value){
      _scaffold.currentState.showSnackBar(new SnackBar(
        content: new Text(value, style: new TextStyle(color: Colors.white),textAlign: TextAlign.center,),
        backgroundColor: Colors.pink[200],
      ));
    }

    bool neg = false;
    
    String checkNegative(String dayLeft){
      int daysLeft = int.parse(dayLeft);
      if(daysLeft < 0){
        // _snackBar('Please fill in your details correctly');
        // Navigator.pop(context);
        neg = true;
        return sqrt(daysLeft*daysLeft).toInt().toString();
      }
      else{
        return daysLeft.toString();
      }
    }

    TextStyle pickedDay = new TextStyle(
      fontSize: 18.0,
      color: Colors.pink
    );
    TextStyle justDay = new TextStyle(
      fontSize: 12.0,
      color: Colors.grey[850]
    );

    TextStyle mainResult = new TextStyle(
      fontSize: 36.0,
      fontWeight: FontWeight.w900,
      color: Colors.pink[700]
    );

    TextStyle firstResult = new TextStyle(
      color: const Color(0xFFFF1744),
      fontSize: 24.0,
      fontWeight: FontWeight.w600
    );

    TextStyle subResult = new TextStyle(
      color: const Color(0xFFFF1744),
      fontSize: 16.0,
      fontWeight: FontWeight.w300
    );
    
    return new Scaffold(
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
        child: new Container(
          margin: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
          color: const Color.fromRGBO(242, 242, 242, 0.68),
          child: new Column(
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.all(30.0),
                padding: const EdgeInsets.all(10.0),
                decoration: new BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: new BorderRadius.all(new Radius.circular(20.0))
                ),
                child: new Row(
                  children: <Widget>[
                    new Expanded(child: new Text('Mon',style: isPickedDay('Mon')?pickedDay:justDay)),
                    new Expanded(child: new Text('Tue',style: isPickedDay('Tue')?pickedDay:justDay)),
                    new Expanded(child: new Text('Wed',style: isPickedDay('Wed')?pickedDay:justDay)),
                    new Expanded(child: new Text('Thu',style: isPickedDay('Thu')?pickedDay:justDay)),
                    new Expanded(child: new Text('Fri',style: isPickedDay('Fri')?pickedDay:justDay)),
                    new Expanded(child: new Text('Sat',style: isPickedDay('Sat')?pickedDay:justDay)),
                    new Expanded(child: new Text('Sun',style: isPickedDay('Sun')?pickedDay:justDay)),
                  ],
                )
              ),
              new Center(
                child: new Column(
                  children: <Widget>[
                    new Container(
                      margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                      padding: const EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 10.0),
                      width: 250.0,
                      height: 250.0,
                      
                      decoration: new BoxDecoration(
                        color: const Color.fromRGBO(255, 82, 116, 0.12),
                        borderRadius: new BorderRadius.all(new Radius.circular(200.0))
                      ),
                      child: new Row(
                        children: <Widget>[
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Container(
                                      padding: const EdgeInsets.only(left: 40.0),
                                      child: Text(checkNegative(results[3]),style: mainResult,textAlign: TextAlign.left,),
                                    ),
                                    new Divider(color: Colors.grey,height: 2.0,),
                                  ]
                                )
                              ),
                              new Container(
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Container(
                                      padding: const EdgeInsets.only(left: 35.0),
                                      child: Text('Days',style: mainResult,textAlign: TextAlign.left,),
                                    ),
                                    new Divider(color: Colors.grey,height: 2.0,),
                                  ]
                                )
                              ),
                              new Container(
                                margin: const EdgeInsets.only(bottom: 15.0),
                                // padding: const EdgeInsets.only(left: 35.0),
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Container(
                                      padding: const EdgeInsets.only(left: 40.0),
                                      child: Text(neg?'Back':'Left',style: mainResult,textAlign: TextAlign.left,),
                                    ),
                                    new Divider(color: Colors.grey,height: 2.0,),
                                  ]
                                )
                              ),
                              new Container(
                                margin: const EdgeInsets.only(bottom: 0.0),
                                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        new Container(
                                          // padding: const EdgeInsets.only(left: 40.0),
                                          child: Text(cutMonth(results[1])+' '+results[0],style: firstResult,textAlign: TextAlign.left,),
                                        ),
                                        
                                      ],
                                    ),
                                    new Divider(color: Colors.grey,height: 2.0,),
                                  ]
                                )
                              ),
                              new Container(
                                padding: const EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
                                child: Text('Next period',style: subResult,textAlign: TextAlign.right,),
                              ),
                              new Container(
                                padding: const EdgeInsets.fromLTRB(35.0, 10.0, 35.0, 0.0),
                                child: new Divider(color: Colors.grey,height: 2.0,),
                              ),
                              
                            ],
                          ),
                          new Container(
                            child: new Image(
                              image: new AssetImage('assets/images/droplets.png',),
                              width: 100.0,
                              height: 150.0,
                            ),
                          )
                        ],
                      )
                    ),
                    new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: new Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            child: new Text('Edit Period Date', style: new TextStyle(color: Colors.white,fontSize: 16.0),),
                            decoration: new BoxDecoration(
                              color: const Color(0xFF2D9CDB),
                              borderRadius: new BorderRadius.all(new Radius.circular(30.0))
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              )
            ]
          )
        )
      )
    );
  }

  String cutMonth(String month){
    if(month.length > 4){
      month = month.substring(0,3);
    }
    return month;
  }

}