import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_up/pages/auth/pages/login/view/base_login_page.dart';
import 'package:way_up/pages/game/game_page.dart';
import 'package:way_up/pages/init/cubit/init_cubit.dart';

class InitPage extends StatelessWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitCubit, InitState>(
      builder: (context, state) {
        if (state is LoggedIn) {
          return const GamePage();
        } else {
          return const BaseLoginPage();
        }
      },
    );
  }
}
