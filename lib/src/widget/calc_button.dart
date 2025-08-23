import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String value;
  final void Function(String value) onPressed;
  final bool isNumber;
  const CalcButton({
    required this.value,
    required this.isNumber,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(0),
          backgroundColor: WidgetStatePropertyAll(
            isNumber
                ? Theme.of(context).colorScheme.surfaceContainer
                : Theme.of(context).colorScheme.surfaceTint,
          ),
          
        ),
        onPressed: () => onPressed(value),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: TextStyle(
              color: isNumber
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.onSecondary,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
