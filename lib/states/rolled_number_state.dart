import 'package:yet_another_rng/widgets/number.dart';

abstract class RolledNumberState {

}

class SuccessState implements RolledNumberState {
  Number number;

  SuccessState(this.number);
}

class ErrorState implements RolledNumberState {

  String message;

  ErrorState(this.message);
}

class InitState implements RolledNumberState {
  String message;

  InitState(this.message);
}