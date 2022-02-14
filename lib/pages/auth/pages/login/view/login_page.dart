import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_up/config/constants/routes_const.dart';
import 'package:way_up/config/route_arguments/phone_check_arguments.dart';
import 'package:way_up/pages/auth/pages/login/bloc/login_bloc.dart';
import 'package:way_up/pages/auth/pages/login/view/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.loginSuccess) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Routes.game, (_) => false);
        }
      },
      child: LoginForm(),
    );
  }
}
