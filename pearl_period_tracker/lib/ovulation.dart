import 'package:flutter/material.dart';
import 'dart:async';
import './ovulationresult.dart';


class Ovulation extends StatefulWidget{
  @override
  State createState() => new OvulationState();
}

class OvulationState extends State<Ovulation>{
  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  DateTime now = new DateTime.now();

  String fullDate;
  DateTime pickedDate;

  DateTime ovulateDate;

  int pickedDay;
  int pickedMonth;
  int pickedYear;
  int pickedWeekDay;
  int cycle;

  bool trackCheck;
  bool cycleCheck;

  
  @override
  void initState(){
    super.initState();
    setState((){
      trackCheck = false;
      cycle = 28;
      cycleCheck = false;
    });
  }

  Future<Null> _selectedDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: new DateTime(2016),
      lastDate: new DateTime(2020)
    );
    if(picked != null){
      setState(() {
        pickedDate = picked;
      });
    }
  }

  String finalDate(){
    // _selectedDate(context);
    pickedDay = pickedDate.day;
    pickedMonth = pickedDate.month;
    pickedYear = pickedDate.year;
    pickedWeekDay = pickedDate.weekday;

    fullDate = formatDate(getWeekDay(pickedWeekDay), dayPosition(pickedDay), getMonth(pickedMonth), pickedYear.toString());

    return fullDate;
  }

  String dayPosition(int daypos){
    if(daypos == 1 || daypos == 21 || daypos == 31) return daypos.toString()+'st';
    else if(daypos == 2 || daypos == 22) return daypos.toString()+'nd';
    else if(daypos == 3 || daypos == 23) return daypos.toString()+'rd';
    else return daypos.toString()+'th';
  }

  String formatDate(String fweekday,String fday,String fmonth,String fyear){
    return fweekday+', '+fday+' '+fmonth+', '+fyear;
  }


  @override
  Widget build(BuildContext context){
    TextStyle _ovulateText = new TextStyle(
      fontSize: 18.0
    );

    TextStyle dateText = new TextStyle(
      color: Colors.pink[700],
      fontSize: 24.0,
      letterSpacing: 1.0
    );

    void _snackBar(String value){
      _scaffold.currentState.showSnackBar(new SnackBar(
        content: new Text(value, style: new TextStyle(color: Colors.white),textAlign: TextAlign.center,),
        backgroundColor: Colors.pink[200],
      ));
    }
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
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Container(
                  color: Colors.white70,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.all(15.0),
                  child: new Text('Track My Ovulation/Fertility',style: _ovulateText,textAlign: TextAlign.center,),
                ),
              ],
            ),
            new Container(
              decoration: new BoxDecoration(
                color: const Color.fromRGBO(242, 242, 242, 0.68),
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 20.0),
                    child: new Text('First day of your last period',style: _ovulateText,),
                  ),
                  new InkWell(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          margin: const EdgeInsets.fromLTRB(15.0, 0.0, 20.0, 5.0),
                          child: new Text(pickedDate == null 
                          ? formatDate(getWeekDay(now.weekday), now.day.toString(), getMonth(now.month), now.year.toString())
                          : finalDate(), style: dateText,),
                          // onPressed: (){_selectedDate(context);},
                        ),
                        new Container(
                          margin: const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                          child: new Divider(height: 2.0,color: Colors.grey,),
                        )
                      ],
                    ),
                    onTap: (){
                      _selectedDate(context);
                    },
                  ),
                  new Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
                        child: new Checkbox(
                          value: trackCheck,
                          onChanged: (bool value){
                            if(pickedDay == null) _snackBar("Please select a date");
                            else{
                              setState(() {
                                trackCheck = value;
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  new Divider(height: 1.0,color: Colors.grey[350],),


                  new Container(
                    padding: const EdgeInsets.all(15.0),
                    child: new Text('Length of your cycle',style: _ovulateText,),
                  ),
                  new Container(
                    margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          margin: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                          child: cycleDropdown(),
                        ),
                      ],
                    )
                    
                  ),
                  new Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
                        child: new Checkbox(
                          value: cycleCheck,
                          onChanged: (bool value){
                            setState(() {
                              cycleCheck = value;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  new Divider(height: 1.0,color: Colors.grey[350],),
                  new Center(
                    child: new Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: new Container(
                          margin: const EdgeInsets.only(top: 20.0),
                        padding: const EdgeInsets.fromLTRB(60.0, 10.0, 60.0, 12.0),
                        decoration: new BoxDecoration(
                          color: const Color(0xFF6FCF97),
                          borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
                        ),
                        
                        child: new InkWell(
                          child: new Text('Track',style: new TextStyle(color: Colors.white,fontSize: 18.0),),
                          onTap: (){
                            if(trackCheck == false || cycleCheck == false) _snackBar("Be sure you checked both boxes");
                            else{
                              Navigator.push(context, 
                                new MaterialPageRoute(
                                  builder: (context) => new OvulationResult(results: toResult())
                                )
                              );
                            }
                          }
                        ),
                      ),
                    )
                ),

                ],
              )
            )
          ],
        ),
      )
    );
  }
  DateTime toResult(){
    DateTime result;
    int halfCycle = (cycle~/2);
    ovulateDate = pickedDate.add(new Duration(days: halfCycle));
    result = ovulateDate;

    return result;
  }

  Widget cycleDropdown(){
    
    TextStyle _cycleText = new TextStyle(
      color: Colors.pink[700],
      fontSize: 16.0,
      letterSpacing: 1.0
    );

    return new DropdownButton<int>(
      items: getCycle().map((var value){
        return new DropdownMenuItem<int>(child: new Text('$value days',style: _cycleText),value: value);
      }).toList(),
      onChanged: (var value){
        setState(() {
          cycle = value;
        });
      },
      value: cycle,
      elevation: 10,
    );
  }

  List getCycle(){
    return [24,25,26,27,28,29,30,31,32];
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

}