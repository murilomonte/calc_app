import 'package:calc_app/src/widget/calc_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String input = '';
  String result = '';

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

  void addInput(String value) {
    setState(() {
      input += value;
    });
  }

  void calc(BuildContext context) {
    try {
      Expression expression = parser(input);

      ContextModel contextModel = ContextModel();
      RealEvaluator eval = RealEvaluator(contextModel);

      setState(() {
        result = eval.evaluate(expression).toString();
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 10,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        input,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        result,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 60,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onLongPress: () {
                      setState(() {
                        result = '';
                        input = '';
                      });
                    },
                    onPressed: () {
                      setState(() {
                        result = '';
                        input = input.substring(0, input.length - 1);
                      });
                    },
                    icon: Icon(Icons.backspace_outlined),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: GridView.count(
              padding: EdgeInsets.all(10),
              crossAxisCount: 4,
              children:
                  [
                    'AC',
                    '(',
                    ')',
                    '÷',
                    '7',
                    '8',
                    '9',
                    '+',
                    '4',
                    '5',
                    '6',
                    '×',
                    '1',
                    '2',
                    '3',
                    '-',
                    '0',
                    ',',
                    '%',
                    '=',
                  ].map((e) {
                    return CalcButton(
                      isNumber: double.tryParse(e) != null,
                      value: e,
                      onPressed: (value) {
                        if (e == '=') {
                          calc(context);
                        } else if (e == 'AC') {
                          setState(() {
                            input = '';
                            result = '';
                          });
                        } else {
                          setState(() {
                            input += value;
                          });
                        }
                      },
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
