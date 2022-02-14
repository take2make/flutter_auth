import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:way_up/services/storage_service/local_storage_service.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit() : super(InitInitial()) {
    initializeCubit();
  }

  Future<void> initializeCubit() async {
    var isLoggedIn = LocalStorageService.getBool(PreferenceKey.isLoggedIn);
    if (isLoggedIn) {
      emit(LoggedIn());
    } else {
      emit(NeedToLogin());
    }
  }
}
