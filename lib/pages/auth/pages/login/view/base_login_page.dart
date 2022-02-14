import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_up/pages/auth/pages/login/bloc/login_bloc.dart';
import 'package:way_up/pages/auth/pages/login/repository/login_repository.dart';
import 'package:way_up/pages/auth/pages/login/view/login_page.dart';

class BaseLoginPage extends StatelessWidget {
  const BaseLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginBloc(repository: LoginRepository());
      },
      child: const LoginPage(),
    );
  }
}
