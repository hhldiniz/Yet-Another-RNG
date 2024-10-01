class Settings {
  int? minimum;
  int? maximum;

  Settings({this.minimum = 0, this.maximum = 100});

  Settings copyWith({

    final int? minimum,
    final int? maximum,

  }) {
    return Settings(
      minimum: minimum ?? this.minimum,
      maximum: maximum ?? this.maximum
    );

  }
}