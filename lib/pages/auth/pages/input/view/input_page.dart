import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_up/config/constants/routes_const.dart';
import 'package:way_up/config/route_arguments/input_arguments.dart';
import 'package:way_up/config/route_arguments/success_arguments.dart';
import 'package:way_up/pages/auth/pages/input/bloc/input_bloc.dart';
import 'package:way_up/pages/auth/pages/input/view/input_form.dart';

class InputPage extends StatelessWidget {
  final InputRouteArgumets inputArguments;
  const InputPage({Key? key, required this.inputArguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<InputBloc, InputState>(
      listener: (context, state) {
        if (state.inputSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.successPage,
            (route) => false,
            arguments: SuccessArguments(
                isRegistration: inputArguments.isRegister,
                phoneNumber: inputArguments.phoneNumber),
          );
        }
      },
      child: InputForm(
        inputArguments: inputArguments,
      ),
    );
  }
}
