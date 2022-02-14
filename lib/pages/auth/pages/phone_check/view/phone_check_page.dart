import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_up/config/constants/routes_const.dart';
import 'package:way_up/config/route_arguments/input_arguments.dart';
import 'package:way_up/config/route_arguments/phone_check_arguments.dart';
import 'package:way_up/pages/auth/pages/phone_check/bloc/phone_check_bloc.dart';
import 'package:way_up/pages/auth/pages/phone_check/view/phone_check_form.dart';

class PhoneCheckPage extends StatelessWidget {
  final PhoneCheckArguments phoneCheckArguments;
  const PhoneCheckPage({Key? key, required this.phoneCheckArguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneCheckBloc, PhoneCheckState>(
      listener: (context, state) {
        if (state.registerSuccess) {
          Navigator.of(context).pushNamed(Routes.inputPhoneCheckCode,
              arguments: InputRouteArgumets(
                  phoneNumber: state.phoneNumber.value,
                  isRegister: phoneCheckArguments.isRegistration));
        }
      },
      child: PhoneCheckForm(
        phoneCheckArguments: phoneCheckArguments,
      ),
    );
  }
}
