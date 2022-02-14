part of 'phone_check_bloc.dart';

class PhoneCheckState extends Equatable {
  const PhoneCheckState({
    this.status = FormzStatus.pure,
    this.phoneNumber = const PhoneNumber.pure(),
  });

  final FormzStatus status;
  final PhoneNumber phoneNumber;

  PhoneCheckState copyWith({
    FormzStatus? status,
    PhoneNumber? phoneNumber,
    Password? password,
  }) {
    return PhoneCheckState(
      status: status ?? this.status,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  bool get registerSuccess {
    return status == FormzStatus.submissionSuccess &&
        phoneNumber != const PhoneNumber.pure();
  }

  @override
  List<Object> get props => [status, phoneNumber];
}
