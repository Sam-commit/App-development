import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'card.dart';
import 'matter.dart';
import 'calculate.dart';
import 'functionality.dart';

const Color active = Colors.white10;
const Color inactive = Color(0xFF37363f);
const TextStyle number = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.w900,
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Page(),
    );
  }
}

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {

  Color state = Colors.green;
  Color male = inactive;
  Color female = inactive;
  int height = 180;
  int weight = 30;
  int age = 20;

  void tap(int g) {
    if (g == 1) {
      if (male == active)
        male = inactive;
      else {
        male = active;
        female = inactive;
      }
    }

    if (g == 0) {
      if (female == active)
        female = inactive;
      else {
        male = inactive;
        female = active;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF673ab7),
        title: Center(
            child: Text(
          'BMI calculator',
          style: TextStyle(fontSize: 30.0),
        )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        tap(1);
                      });
                    },
                    child: Cardme(
                      colour: male,
                      cardw: matter(pic: FontAwesomeIcons.mars, label: 'MALE'),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        tap(0);
                      });
                    },
                    child: Cardme(
                      colour: female,
                      cardw: matter(
                        pic: FontAwesomeIcons.venus,
                        label: 'FEMALE',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Cardme(
            colour: Colors.white10,
            cardw: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'HEIGHT',
                    style: labelstyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        height.toString(),
                        style: number,
                      ),
                      Text(
                        'cm',
                        style: labelstyle,
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 12.0),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 30.0),
                      overlayColor: Color(0x643f51b5),
                      activeTrackColor: Color(0xFF3f51b5),
                      inactiveTrackColor: Colors.white,
                    ),
                    child: Slider(
                        value: height.toDouble(),
                        min: 100.0,
                        max: 250.0,
                        onChanged: (double newvalue) {
                          setState(() {
                            height = newvalue.round();
                          });
                        }),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Cardme(
                  colour: Colors.white10,
                  cardw: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'WEIGTH',
                        style: labelstyle,
                      ),
                      Text(
                        weight.toString(),
                        style: number,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Mybutton(
                            icon: FontAwesomeIcons.minus,
                            onpressed: () {
                              setState(() {
                                weight--;
                              });
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Mybutton(
                            icon: FontAwesomeIcons.plus,
                            onpressed: () {
                              setState(() {
                                weight++;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Cardme(
                  colour: Colors.white10,
                  cardw: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'AGE',
                        style: labelstyle,
                      ),
                      Text(
                        age.toString(),
                        style: number,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Mybutton(
                            icon: FontAwesomeIcons.minus,
                            onpressed: () {
                              setState(() {
                                age--;
                              });
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Mybutton(
                            icon: FontAwesomeIcons.plus,
                            onpressed: () {
                              setState(() {
                                age++;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Functionality func = Functionality(height: height,weight: weight);
              func.getbmi();
              setState(() {

                if(func.getstatus()=='OVERWEIGHT'){
                  state = Color(0xFFe53935);
                }

                else if(func.getstatus()=='UNDERWEIGHT'){
                  state = Color(0xFFff6f00);
                }

                else if(func.getstatus()=='NORMAL'){
                  state = Color(0xFF2e7d32);
                }

                else{
                  state = Colors.green;
                }

              });


              Navigator.push(context,
              MaterialPageRoute(builder: (context) => Result(

                bmi: func.getbmi(),
                status: func.getstatus(),
                statement: func.getstatement(),
                col: state,

              ))
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 10.0),
              color: Color(0xFF673ab7),
              height: 65.0,
              child: Center(
                  child: Text(
                'Calculate',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              )),
            ),
          )
        ],
      ),
    );
  }
}

class Mybutton extends StatelessWidget {
  Mybutton({this.icon, this.onpressed});

  final IconData icon;
  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onpressed,
      child: Icon(
        icon,
        size: 30.0,
      ),
      constraints: BoxConstraints.tightFor(
        width: 50.0,
        height: 50.0,
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFF616161),
      elevation: 5.0,
    );
  }
}
