import 'package:flutter/material.dart';
import 'package:way_up/config/constants/routes_const.dart';

class InitPage extends StatelessWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.training);
        },
        child: Container(color: Colors.amberAccent),
      )),
    );
  }
}
