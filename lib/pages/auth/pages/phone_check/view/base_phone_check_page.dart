import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_up/config/route_arguments/phone_check_arguments.dart';
import 'package:way_up/pages/auth/pages/phone_check/bloc/phone_check_bloc.dart';
import 'package:way_up/pages/auth/pages/phone_check/repository/phone_check_repository.dart';
import 'package:way_up/pages/auth/pages/phone_check/view/phone_check_page.dart';

class BasePhoneCheckPage extends StatelessWidget {
  final PhoneCheckArguments phoneCheckArguments;
  const BasePhoneCheckPage({Key? key, required this.phoneCheckArguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PhoneCheckBloc(repository: PhoneCheckRepository());
      },
      child: PhoneCheckPage(
        phoneCheckArguments: phoneCheckArguments,
      ),
    );
  }
}
