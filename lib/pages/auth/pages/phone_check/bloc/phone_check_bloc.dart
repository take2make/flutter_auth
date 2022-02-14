import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:way_up/pages/auth/pages/login/models/models.dart';
import 'package:way_up/pages/auth/pages/phone_check/repository/phone_check_repository.dart';

part 'phone_check_event.dart';
part 'phone_check_state.dart';

class PhoneCheckBloc extends Bloc<PhoneCheckEvent, PhoneCheckState> {
  final PhoneCheckRepository repository;
  PhoneCheckBloc({required this.repository}) : super(const PhoneCheckState()) {
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<RestoreSubmitted>(_onRestoreSubmitted);
  }

  void _onPhoneNumberChanged(
    PhoneNumberChanged event,
    Emitter<PhoneCheckState> emit,
  ) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(state.copyWith(
      phoneNumber: phoneNumber,
      status: Formz.validate([phoneNumber]),
    ));
  }

  void _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<PhoneCheckState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      await Future.delayed(Duration(seconds: 1));
      try {
        if (state.phoneNumber == const PhoneNumber.dirty("+7(901)753-10-93")) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } else {
          _onPhoneNumberChanged(const PhoneNumberChanged(""), emit);
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  void _onRestoreSubmitted(
    RestoreSubmitted event,
    Emitter<PhoneCheckState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      await Future.delayed(Duration(seconds: 1));
      try {
        if (state.phoneNumber == const PhoneNumber.dirty("+7(901)753-10-93")) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } else {
          _onPhoneNumberChanged(const PhoneNumberChanged(""), emit);
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
