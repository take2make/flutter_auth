import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:way_up/pages/auth/pages/input/models/code.dart';
import 'package:way_up/pages/auth/pages/input/repository/input_repository.dart';
part 'input_event.dart';
part 'input_state.dart';

class InputBloc extends Bloc<InputEvent, InputState> {
  final InputRepository repository;
  InputBloc({required this.repository}) : super(const InputState()) {
    on<InputCodeChanged>(_onCodeChanged);
    on<InputCodeSubmitted>(_onSubmitted);
  }

  void _onCodeChanged(
    InputCodeChanged event,
    Emitter<InputState> emit,
  ) {
    final code = Code.dirty(event.code);
    emit(state.copyWith(
      code: code,
      status: Formz.validate([code]),
    ));
  }

  void _onSubmitted(
    InputCodeSubmitted event,
    Emitter<InputState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      await Future.delayed(Duration(seconds: 1));
      try {
        if (state.code == const Code.dirty("1234")) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } else {
          _onCodeChanged(const InputCodeChanged(""), emit);
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
