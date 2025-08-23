import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalcController extends ChangeNotifier {
  String input = '';
  String result = '';

  bool isOperator(String value) {
    return ['+', '-', '*', '/', '×', '÷', '%'].contains(value);
  }

  void determine(String value) {
    if (value == '=') {
      calc();
    } else if (value == 'AC') {
      clear();
    } else {
      _addInput(value);
    }
  }

  void _addInput(String value) {
    if (isOperator(value) &&
        input.isNotEmpty &&
        isOperator(input[input.length - 1])) {
      return;
    }
    input += value;
    notifyListeners();
  }

  void backspace() {
    if (input.isNotEmpty) {
      input = input.substring(0, input.length - 1);
      notifyListeners();
    }
  }

  void clear() {
    input = '';
    result = '';
    notifyListeners();
  }

  Expression parser(String exp) {
    try {
      GrammarParser parser = GrammarParser();
      String formatedExpression = exp
          .replaceAll('×', '*')
          .replaceAll(',', '.')
          .replaceAll('÷', '/')
          .replaceAll('%', '/100*');

      Expression expression = parser.parse(formatedExpression);

      return expression;
    } catch (error) {
      throw FormatException('Formato inválido');
    }
  }

  void calc() {
    if (input.isEmpty) return;

    try {
      Expression expression = parser(input);

      ContextModel contextModel = ContextModel();
      RealEvaluator eval = RealEvaluator(contextModel);

      result = eval.evaluate(expression).toString();
      notifyListeners();
    } catch (error) {
      result = 'Error';
      rethrow;
    }
  }
}
