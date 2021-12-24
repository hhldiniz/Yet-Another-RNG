import 'package:yet_another_rng/presentations/number_presentation.dart';

abstract class RolledNumberState {

}

class SuccessState implements RolledNumberState {
  NumberPresentation numberPresentation;

  SuccessState(this.numberPresentation);
}

class ErrorState implements RolledNumberState {

  String message;

  ErrorState(this.message);
}

class InitState implements RolledNumberState {
  String message;

  InitState(this.message);
}