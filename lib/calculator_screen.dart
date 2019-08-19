import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'constants.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CalculatorScreen extends StatefulWidget {
  CalculatorScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  Parser p = Parser();
  ContextModel cm = ContextModel();

  String result = '0';
  String calculation = '0';

  FlatButton numberButton(String number) {
    return FlatButton(
      onPressed: () {
        setState(() {
          if (calculation == '0') {
            calculation = number;
          } else {
            calculation += number;
          }
        });
      },
      child: Text(
        number,
        style: kNumberButtonStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: AutoSizeText(
                          calculation,
                          style: kCalculationStyle,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: AutoSizeText(
                          result,
                          style: kOutputTextStyle,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 350.0,
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    setState(() {
                      calculation = '0';
                      result = '0';
                    });
                  },
                  child: Text(
                    'C',
                    style: kExtraFunctionButtonStyle,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      calculation = (calculation.length > 0)
                          ? (calculation.substring(0, calculation.length - 1))
                          : '';
                    });
                  },
                  child: Icon(
                    Icons.backspace,
                    color: kExtraFunctionsColor,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      Expression exp = p.parse(calculation + '/100');
                      result = exp.evaluate(EvaluationType.REAL, cm).toString();
                    });
                  },
                  child: Text(
                    '%',
                    style: kExtraFunctionButtonStyle,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      calculation += '/';
                    });
                  },
                  child: Text(
                    '/',
                    style: kOperationButtonStyle,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                numberButton('7'),
                numberButton('8'),
                numberButton('9'),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      calculation += '*';
                    });
                  },
                  child: Text(
                    'X',
                    style: kOperationButtonStyle,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                numberButton('4'),
                numberButton('5'),
                numberButton('6'),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      calculation += '-';
                    });
                  },
                  child: Text(
                    '-',
                    style: kOperationButtonStyle,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                numberButton('1'),
                numberButton('2'),
                numberButton('3'),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      calculation += '+';
                    });
                  },
                  child: Text(
                    '+',
                    style: kOperationButtonStyle,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                numberButton('00'),
                numberButton('0'),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      calculation += '.';
                    });
                  },
                  child: Text(
                    '.',
                    style: kExtraFunctionButtonStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        Expression exp = p.parse(calculation);
                        result =
                            exp.evaluate(EvaluationType.REAL, cm).toString();
                      });
                    },
                    backgroundColor: kOperationButtonColor,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
                      child: Text(
                        '=',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
