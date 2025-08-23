import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalcController extends ChangeNotifier {
  String input = '';
  String result = '';

  // parser
  // addinput
  // calc -> método principal que vai redirecionar tudo (Talvez seja uma má prática)


  Expression parser(String exp) {
    try {
      GrammarParser parser = GrammarParser();

      String formatedExpression = exp.replaceAll('×', '*').replaceAll('÷', '/');

      Expression expression = parser.parse(formatedExpression);
      return expression;
    } catch (error) {
      throw FormatException('Formato inválido');
    }
  }

  void addInput(String value) {
    input += value;
  }

  void calc(BuildContext context) {
    try {
      Expression expression = parser(input);

      ContextModel contextModel = ContextModel();
      RealEvaluator eval = RealEvaluator(contextModel);

      result = eval.evaluate(expression).toString();
    } on FormatException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.message)));
    } catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}
