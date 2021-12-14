import 'package:flutter/material.dart';

class Number extends StatelessWidget {
  final String _numberText;

  const Number(this._numberText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _numberText,
      style: const TextStyle(fontSize: 260, color: Colors.white),
    );
  }
}
