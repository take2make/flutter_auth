part of 'input_bloc.dart';

class InputState extends Equatable {
  const InputState({
    this.status = FormzStatus.pure,
    this.code = const Code.pure(),
  });

  final FormzStatus status;
  final Code code;

  InputState copyWith({
    FormzStatus? status,
    Code? code,
  }) {
    return InputState(
      status: status ?? this.status,
      code: code ?? this.code,
    );
  }

  bool get inputSuccess {
    return status == FormzStatus.submissionSuccess && code != const Code.pure();
  }

  @override
  List<Object> get props => [status, code];
}
