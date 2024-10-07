import 'package:flutter/material.dart';

class Number extends StatelessWidget {
  final int newValue;
  final int? oldValue;

  const Number({Key? key, required this.oldValue, required this.newValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Card(
        shape: const CircleBorder(),
        elevation: 8,
        child: Padding(
            padding: const EdgeInsets.all(2),
            child: NumberText(
              duration: const Duration(seconds: 1),
              oldValue: oldValue,
              newValue: newValue,
            )),
      ),
    );
  }
}

class NumberText extends ImplicitlyAnimatedWidget {
  final int newValue;
  final int? oldValue;

  const NumberText(
      {Key? key,
      required Duration duration,
      required this.oldValue,
      required this.newValue})
      : super(key: key, duration: duration);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return _NumberTextState();
  }
}

class _NumberTextState extends AnimatedWidgetBaseState<NumberText> {
  late IntTween _number;

  @override
  void initState() {
    _number = IntTween(
        begin: widget.oldValue ?? widget.newValue, end: widget.newValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _number.evaluate(animation).toString().padLeft(2, '0'),
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _number = visitor(
      _number,
      widget.newValue,
      (targetValue) => IntTween(begin: targetValue),
    ) as IntTween;
  }
}
