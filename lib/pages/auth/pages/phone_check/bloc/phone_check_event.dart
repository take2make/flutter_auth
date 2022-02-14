part of 'phone_check_bloc.dart';

abstract class PhoneCheckEvent extends Equatable {
  const PhoneCheckEvent();

  @override
  List<Object> get props => [];
}

class PhoneNumberChanged extends PhoneCheckEvent {
  const PhoneNumberChanged(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class RegisterSubmitted extends PhoneCheckEvent {
  const RegisterSubmitted();
}

class RestoreSubmitted extends PhoneCheckEvent {
  const RestoreSubmitted();
}
