import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:way_up/pages/auth/pages/login/models/models.dart';
import 'package:way_up/pages/auth/pages/login/repository/login_repository.dart';
import 'package:way_up/services/storage_service/local_storage_service.dart';
import 'package:way_up/singletons/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;
  LoginBloc({required this.repository}) : super(const LoginState()) {
    on<LoginPhoneNumberChanged>(_onPhoneNumberChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onPhoneNumberChanged(
    LoginPhoneNumberChanged event,
    Emitter<LoginState> emit,
  ) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(state.copyWith(
      phoneNumber: phoneNumber,
      status: Formz.validate([state.password, phoneNumber]),
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.phoneNumber]),
    ));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      await Future.delayed(Duration(seconds: 1));
      try {
        if (state.phoneNumber == const PhoneNumber.dirty("+7(901)753-10-93") &&
            state.password == const Password.dirty("abc")) {
          LocalStorageService.setBool(PreferenceKey.isLoggedIn, true);
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } else {
          _onPhoneNumberChanged(const LoginPhoneNumberChanged(""), emit);
          _onPasswordChanged(const LoginPasswordChanged(""), emit);
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
