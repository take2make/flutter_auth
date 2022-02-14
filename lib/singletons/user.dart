import 'package:way_up/services/storage_service/local_storage_service.dart';

class User {
  String firstName = "";
  String secondName = "";
  String phoneNumber = "";
  String accessToken = "";
  String refreshToken = "";

  static final User _instance = User._internal();
  factory User() {
    return _instance;
  }

  initialize() {
    accessToken = LocalStorageService.getValue(PreferenceKey.accessToken);
    refreshToken = LocalStorageService.getValue(PreferenceKey.refreshToken);
    firstName = "alex";
    secondName = "lutix";
    phoneNumber = "+7(901)753-10-93";
  }

  clear() {
    firstName = "";
    secondName = "";
    phoneNumber = "";
  }

  User._internal() {
    initialize();
  }
}
