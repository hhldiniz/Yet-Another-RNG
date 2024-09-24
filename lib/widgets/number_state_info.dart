import 'package:flutter/material.dart';

class NumberStateInfoWidget extends StatelessWidget {
  final String _info;

  const NumberStateInfoWidget(this._info, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Text(
          _info,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ));
  }
}
