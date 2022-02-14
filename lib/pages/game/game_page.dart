import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:way_up/config/themes/text_theme.dart';
import 'package:way_up/services/storage_service/local_storage_service.dart';
import 'package:way_up/singletons/user.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("hello ${User().firstName}"),
          ),
          CupertinoButton(
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Text(
                  "exit",
                  style: AppTextStyle.mainTextStyle1,
                ),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.red),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
              onPressed: () {
                LocalStorageService.setBool(PreferenceKey.isLoggedIn, false);
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("/", (_) => false);
              })
        ],
      ),
    );
  }
}
