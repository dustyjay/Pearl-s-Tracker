import 'package:flutter/material.dart';

class OvulationResult extends StatefulWidget{
  final DateTime results;

  OvulationResult({Key key,this.results}):super(key:key);
  @override
  State createState() => new OvulationResultState();
}

class OvulationResultState extends State<OvulationResult>{
  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();

  DateTime results;

  @override
  void initState(){
    super.initState();
    setState(() {
      results = widget.results;
    });
  }
  
  bool isPickedDay(String day){
    if(day == getWeekDay(results.weekday)) return true;
    return false;
  }

  @override
  Widget build(BuildContext context){
    TextStyle _trackerText = new TextStyle(
      fontSize: 18.0
    );

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
      fontSize: 22.0,
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
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Text('Stay',style: mainResult,textAlign: TextAlign.left,),
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
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Text('Healthy',style: mainResult,textAlign: TextAlign.left,),
                              ),
                                new Divider(color: Colors.grey,height: 2.0,),
                            ]
                          )
                        ),
                        new Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: new Divider(color: Colors.grey,height: 2.0,),
                        ),
                        new Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    child: Text(fertile(),style: firstResult,textAlign: TextAlign.left,),
                                  ),
                                  new Divider(height:2.0,color:Colors.grey),
                                  new Container(
                                    padding: const EdgeInsets.only(left: 60.0),
                                    margin: const EdgeInsets.only(bottom: 5.0),
                                    child: Text('Next Fertile',style: subResult,textAlign: TextAlign.right,),
                                  ),
                                ],
                              ),
                            ]
                          )
                        ),
                        new Container(
                          padding: const EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 0.0),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    child: Text(cutMonth(getMonth(results.month))+' '+results.day.toString(),style: firstResult,textAlign: TextAlign.left,),
                                  ),
                                  new Divider(height:2.0,color:Colors.grey),
                                  new Container(
                                    padding: const EdgeInsets.only(left: 50.0),
                                    child: Text('Ovulation',style: subResult,textAlign: TextAlign.right,),
                                  ),
                                ],
                              ),
                            ]
                          )
                        ),
                        
                      ],
                    ),
                    new Container(
                      child: new Image(
                        image: new AssetImage('assets/images/droplets.png',),
                        width: 50.0,
                        height: 150.0,
                      ),
                    )
                  ],
                ),
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
                      child: new Text('Edit Ovulation Date', style: new TextStyle(color: Colors.white,fontSize: 16.0),),
                      decoration: new BoxDecoration(
                        color: const Color(0xFF2D9CDB),
                        borderRadius: new BorderRadius.all(new Radius.circular(30.0))
                      ),
                    ),
                  )
                ],
              )
              
            ],
          ),
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

  String fertile(){
    DateTime backDate = results.subtract(new Duration(days: 2));
    DateTime forDate = results.add(new Duration(days: 2));
    return cutMonth(getMonth(backDate.month))+' '+backDate.day.toString()+' - '+forDate.day.toString();
  }
  
  String getMonth(int value){
    List months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
    switch (value) {
      case 1:
        return months[0];
        break;

      case 2:
        return months[1];
        break;
      case 3:
        return months[2];
        break;

      case 4:
        return months[3];
        break;
      case 5:
        return months[4];
        break;

      case 6:
        return months[5];
        break;
      case 7:
        return months[6];
        break;

      case 8:
        return months[7];
        break;
      case 9:
        return months[8];
        break;

      case 10:
        return months[9];
        break;
      case 11:
        return months[10];
        break;

      case 12:
        return months[11];
        break;
      default:
        return months[0];
    }
  }
  
  String getWeekDay(int value){
    List weekdays = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
    switch (value) {
      case 0:
        return weekdays[0];
        break;

      case 1:
        return weekdays[1];
        break;

      case 2:
        return weekdays[2];
        break;

      case 3:
        return weekdays[4];
        break;
      case 4:
        return weekdays[4];
        break;

      case 5:
        return weekdays[5];
        break;

      case 6:
        return weekdays[6];
        break;
      
      default:
        return weekdays[0];
    }
  }

}