import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_up/config/route_arguments/input_arguments.dart';
import 'package:way_up/pages/auth/pages/input/bloc/input_bloc.dart';
import 'package:way_up/pages/auth/pages/input/repository/input_repository.dart';

import 'package:way_up/pages/auth/pages/input/view/input_page.dart';

class BaseInputPage extends StatelessWidget {
  final InputRouteArgumets inputArguments;
  const BaseInputPage({Key? key, required this.inputArguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return InputBloc(repository: InputRepository());
      },
      child: InputPage(
        inputArguments: inputArguments,
      ),
    );
  }
}
