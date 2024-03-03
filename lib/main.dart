import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _operator = "";
  double _num1 = 0;

  void _handleButtonPress(String value) {
    setState(() {
      if (value == "C") {
        _clear();
      } else if (value == "=") {
        _calculate();
      } else if (_isOperator(value)) {
        _handleOperator(value);
      } else {
        _handleDigit(value);
      }
    });
  }

  void _clear() {
    _output = "0";
    _operator = "";
    _num1 = 0;
  }

  void _calculate() {
    if (_operator.isNotEmpty) {
      double num2 = double.parse(_output);
      _output = _performOperation(_num1, num2, _operator).toString();
      _num1 = double.parse(_output);
      _operator = "";
    }
  }

  void _handleOperator(String value) {
    _num1 = double.parse(_output);
    _operator = value;
  }

  void _handleDigit(String value) {
    _output = (_output == "0" || _operator.isNotEmpty) ? value : _output + value;
  }

  bool _isOperator(String value) => value == "+" || value == "-" || value == "×" || value == "÷";

  double _performOperation(double num1, double num2, String operator) {
    switch (operator) {
      case "+":
        return num1 + num2;
      case "-":
        return num1 - num2;
      case "×":
        return num1 * num2;
      case "÷":
        return num1 / num2;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Calculator"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(fontSize: 36.0),
              ),
            ),
          ),
          for (int i = 1; i <= 9; i += 3)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int j = i; j <= i + 2; j++) _buildButton(j.toString()),
                _buildButton(_operatorSymbols[i ~/ 3]),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton("0"),
              _buildButton("C"),
              _buildButton("="),
              _buildButton("+"),
            ],
          ),
        ],
      ),
    );
  }

  List<String> _operatorSymbols = ["÷", "×", "-", "+"];

  Widget _buildButton(String value) {
    return ElevatedButton(
      onPressed: () => _handleButtonPress(value),
      child: Text(value, style: TextStyle(fontSize: 20.0)),
    );
  }
}
