import 'package:calc_app/src/calc.dart';
import 'package:calc_app/src/controller/calc_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CalcController()),
      ],
      child: CalcApp(),
    ),
  );
}
