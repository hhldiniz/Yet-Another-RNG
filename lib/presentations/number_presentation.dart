class NumberPresentation {
  final int rolledNumber;
  String? message;

  NumberPresentation(this.rolledNumber, {this.message});

  String get numberText => rolledNumber < 10
      ? "0" + rolledNumber.toString()
      : rolledNumber.toString();
}
