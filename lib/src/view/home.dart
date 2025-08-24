import 'package:calc_app/src/controller/calc_controller.dart';
import 'package:calc_app/src/widget/calc_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          context.watch<CalcController>().input,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          context.watch<CalcController>().result,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 60,
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onLongPress: () {
                      context.read<CalcController>().clear();
                    },
                    onPressed: () {
                      context.read<CalcController>().backspace();
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
                        try {
                          context.read<CalcController>().determine(value);
                        } on FormatException catch (error) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(error.message)),
                          );
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
