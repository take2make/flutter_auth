part of 'input_bloc.dart';

abstract class InputEvent extends Equatable {
  const InputEvent();

  @override
  List<Object> get props => [];
}

class InputCodeChanged extends InputEvent {
  const InputCodeChanged(this.code);

  final String code;

  @override
  List<Object> get props => [code];
}

class InputCodeSubmitted extends InputEvent {
  const InputCodeSubmitted();
}
