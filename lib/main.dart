import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


void main() => runApp(Calculator());


class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calhomepage()
    );
  }
}


class Calhomepage extends StatefulWidget {
  @override
  _CalhomepageState createState() => _CalhomepageState();
}

class _CalhomepageState extends State<Calhomepage> {

  String equation = '0';
  String result = '0';
  String expression = '';
  double equationfontsize = 38.0;
  double resultfontsize= 48.0;
  Buttonpressed( String btnvalue){
    setState(() {
      if (btnvalue == 'C') {
        equation = '0';
        result = '0';
        equationfontsize = 38.0;
        resultfontsize = 48.0;
      }
      else if (btnvalue == '<=') {
        equationfontsize = 48.0;
        resultfontsize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      }
      else if (btnvalue == '=') {
        equationfontsize = 38.0;
        resultfontsize = 48.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try{
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)
          }';
        }catch(e){
          result = 'Error';
        }
      }
      else {
        if (equation == '0') {
          equation = btnvalue;
        } else {
          equation = equation + btnvalue;
        }
      }
    });
  }

  Container buildbutton (String btnvalue,double buttonhight,Color buttoncolor, String buttonpressed){
    return Container(
      height: MediaQuery.of(context).size.height *0.1 * buttonhight,
      color: buttoncolor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white,
                  width: 1,
                  style: BorderStyle.solid)
          ),
          padding: EdgeInsets.all(16.0),
          onPressed: () {
            Buttonpressed(btnvalue);
            print(buttonpressed);
          },
          child: Text(
            '$btnvalue',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.symmetric(vertical: 19.0, horizontal: 25.0),
            child: Container(
              alignment: Alignment.centerRight,
              height: 75.0,
              child: Text(equation,
                style: TextStyle(fontSize: equationfontsize),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25.0),
            child: Container(
              alignment: Alignment.centerRight,
              height: 75.0,
              child: Text(result,
                style: TextStyle(fontSize: resultfontsize),
              ),
            ),
          ),
          Expanded(child: Divider(
            color: Colors.grey.shade900,
          ),),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width *0.75,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildbutton('C', 1, Colors.redAccent,'C pressed'),
                          buildbutton('<=', 1, Colors.blue,'beck prassed'),
                          buildbutton('÷', 1, Colors.blue,'/ pressed'),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildbutton('7', 1, Colors.black54,'7 pressed'),
                          buildbutton('8', 1, Colors.black54,'8 pressed'),
                          buildbutton('9', 1, Colors.black54,'9 pressed'),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildbutton('4', 1, Colors.black54,'4 pressed'),
                          buildbutton('5', 1, Colors.black54,'5 pressed'),
                          buildbutton('6', 1, Colors.black54,'6 pressed'),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildbutton('1', 1, Colors.black54,'1 pressed'),
                          buildbutton('2', 1, Colors.black54,'2 pressed'),
                          buildbutton('3', 1, Colors.black54,'3 pressed'),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildbutton('.', 1, Colors.black54,'. pressed'),
                          buildbutton('0', 1, Colors.black54,'0 pressed'),
                          buildbutton('00', 1, Colors.black54,'00 pressed'),
                        ]
                    ),
                  ],
                ),
              ),
              Container(
                width:  MediaQuery.of(context).size.width*0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildbutton('×', 1, Colors.blue,'* pressed')
                        ]
                    ),

                    TableRow(
                        children: [
                          buildbutton('+', 1, Colors.blue,'+ pressed')
                        ]
                    ),
                    TableRow(
                        children: [
                          buildbutton('-', 1, Colors.blue,'- pressed')
                        ]
                    ),

                    TableRow(
                        children: [
                          buildbutton('=', 2, Colors.blue,'= pressed')
                        ]
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


