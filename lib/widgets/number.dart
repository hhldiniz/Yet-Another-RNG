import 'package:flutter/material.dart';

class Number extends StatelessWidget {
  final String _numberText;

  const Number(this._numberText, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(
        _numberText,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
