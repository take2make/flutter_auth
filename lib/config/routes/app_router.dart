import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_up/config/constants/routes_const.dart';
import 'package:way_up/config/route_arguments/input_arguments.dart';
import 'package:way_up/config/route_arguments/phone_check_arguments.dart';
import 'package:way_up/config/route_arguments/success_arguments.dart';
import 'package:way_up/pages/auth/pages/input/view/base_input_page.dart';
import 'package:way_up/pages/auth/pages/login/view/base_login_page.dart';
import 'package:way_up/pages/auth/pages/login/view/login_page.dart';
import 'package:way_up/pages/auth/pages/phone_check/view/base_phone_check_page.dart';
import 'package:way_up/pages/auth/pages/success_page/success_page.dart';
import 'package:way_up/pages/game/game_page.dart';
import 'package:way_up/pages/init/cubit/init_cubit.dart';
import 'package:way_up/pages/init/view/init_page.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    print(routeSettings);
    switch (routeSettings.name) {
      case Routes.home:
        return CupertinoPageRoute(
          builder: (_) => MultiProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) => InitCubit(),
              ),
            ],
            child: const InitPage(),
          ),
        );

      case Routes.login:
        return CupertinoPageRoute(builder: (_) => const BaseLoginPage());

      case Routes.inputPhoneCheckCode:
        return CupertinoPageRoute(
            builder: (_) => BaseInputPage(
                inputArguments: routeSettings.arguments as InputRouteArgumets));

      case Routes.phoneCheck:
        return CupertinoPageRoute(
            builder: (_) => BasePhoneCheckPage(
                phoneCheckArguments:
                    routeSettings.arguments as PhoneCheckArguments));

      case Routes.successPage:
        return CupertinoPageRoute(
            builder: (_) => SuccessPage(
                successArguments: routeSettings.arguments as SuccessArguments));

      case Routes.game:
        return CupertinoPageRoute(builder: (_) => const GamePage());

      default:
        return CupertinoPageRoute(builder: (_) => const InitPage());
    }
  }
}
