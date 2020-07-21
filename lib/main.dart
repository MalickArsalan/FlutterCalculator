import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Calculator(),
      ),
    ),
  );
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Size screen;
  double buttonSize;
  double displayHeight;

  String output = '0';
  String _output = '0';
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = '';
  RegExp regex = RegExp(r"([.]*0)(?!.*\d)");

  Widget buildButtonLabel(label) {
    return Text(
      '$label',
      style: TextStyle(
        fontSize: 30,
      ),
    );
  }

  mathOperations(double number1, double number2, String mathOperator) {
    String result = _output;

    if (mathOperator == '+') {
      result = (number1 + number2).toString();
    }
    if (mathOperator == '-') {
      result = (number1 - number2).toString();
    }
    if (mathOperator == '×') {
      result = (number1 * number2).toString();
    }
    if (mathOperator == '÷') {
      result = (number1 / number2).toString();
    }
    if (mathOperator == '%') {
      result = (number1 % number2).toString();
    }
    return result;
  }

  buttonPressed(String buttonLabel) {
    if (buttonLabel == 'AC') {
      _output = "0";

      num1 = 0.0;

      num2 = 0.0;

      operand = "";
    } else if (buttonLabel == '+' ||
        buttonLabel == '-' ||
        buttonLabel == '×' ||
        buttonLabel == '÷' ||
        buttonLabel == '%' ||
        buttonLabel == '⁺∕₋') {
      num1 = double.parse(output);
      operand = buttonLabel;
      _output = "0";
      if (operand == '⁺∕₋') {
        _output = (num1 * (-1)).toString();
      }
    } else if (buttonLabel == '.') {
      if (_output.contains('.')) {
        print("Already contains a decimals");
      } else {
        _output = _output + buttonLabel;
      }
    } else if (buttonLabel == '=') {
      num2 = double.parse(output);

      _output = mathOperations(num1, num2, operand);

      num1 = 0.0;
      num2 = 0.0;
      operand = '';
    } else {
      _output = _output + buttonLabel;
    }

    print(_output);
    if (_output.contains('.'))
      _output = _output.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");

    setState(() {
      output = (_output.contains('.'))
          ? double.parse(_output)
              .toStringAsFixed(2)
              .replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")
          : int.parse(_output).toString();
    });
  }

  Widget buildButton(String buttonLabel, buttonColor) {
    bool isZero = false;
    isZero = buttonLabel == '0' ? true : false;
    double minWidth = 0.0;
    minWidth = buttonLabel == '0'
        ? MediaQuery.of(context).size.width * .45
        : MediaQuery.of(context).size.width * .22; //175 : 85.0;
    return ButtonTheme(
      minWidth: minWidth,
      height: buttonLabel == '0'
          ? MediaQuery.of(context).size.height * 0.1
          : MediaQuery.of(context).size.height * 0.12, //90 : 100,
      padding: EdgeInsets.all(10),
      child: RaisedButton(
        child: Center(
          child: buildButtonLabel(buttonLabel),
        ),
        onPressed: () {
          buttonPressed(buttonLabel);
        },
        color: Colors.white,
        shape: isZero
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              )
            : CircleBorder(),
        textColor: Color(buttonColor),
        highlightElevation: 0.0,
        highlightColor: Colors.white24,
        splashColor: Colors.white24,
        elevation: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size;
    double buttonSize = screen.width / 4;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              //SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FittedBox(
                    alignment: Alignment.centerRight,
                    fit: BoxFit.contain,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 32.0,
                        horizontal: 16.0,
                      ),
                      alignment: Alignment.centerRight,
                      child: Text(
                        '$output',
                        style: TextStyle(
                          fontSize: 50,
                          fontFamily: 'Source Sans Pro',
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  buildButton('AC', 0xFFD6D6D6),
                  buildButton('⁺∕₋', 0xFFD6D6D6),
                  buildButton('%', 0xFFD6D6D6),
                  buildButton('÷', 0xFFFF98000),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  buildButton('7', 0xFF000000),
                  buildButton('8', 0xFF000000),
                  buildButton('9', 0xFF000000),
                  buildButton('×', 0xFFFF98000),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  buildButton('4', 0xFF000000),
                  buildButton('5', 0xFF000000),
                  buildButton('6', 0xFF000000),
                  buildButton('-', 0xFFFF98000),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  buildButton('1', 0xFF000000),
                  buildButton('2', 0xFF000000),
                  buildButton('3', 0xFF000000),
                  buildButton('+', 0xFFFF98000),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  buildButton('0', 0xFF000000),
                  buildButton('.', 0xFF000000),
                  buildButton('=', 0xFFFF98000),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// FittedBox(
//             alignment: Alignment.centerRight,
//             fit: BoxFit.contain,
//              child:
// )
