import 'package:flutter/material.dart';

class Number extends StatelessWidget {
  final String _numberText;
  final double? _fontSize;

  const Number(this._numberText, {Key? key, double? fontSize}) :
        _fontSize = fontSize,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _numberText,
      style: TextStyle(fontSize: _fontSize ?? 260, color: Colors.white),
    );
  }
}
