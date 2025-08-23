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
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80),
      ),
      onTap: () => onPressed(value),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: isNumber
                ? Theme.of(context).colorScheme.surfaceContainer
                : Theme.of(context).colorScheme.surfaceTint,
            borderRadius: BorderRadius.circular(80),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                color: isNumber
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.onSecondary,
                fontSize: 30
              ),
            ),
          ),
        ),
      ),
    );
  }
}
