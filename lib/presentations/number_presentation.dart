class NumberPresentation {
  final int rolledNumber;
  final int? oldValue;
  String? message;

  NumberPresentation({this.oldValue, required this.rolledNumber, this.message});

  String get numberText => rolledNumber < 10
      ? "0" + rolledNumber.toString()
      : rolledNumber.toString();
}
