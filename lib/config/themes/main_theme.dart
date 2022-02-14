import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:way_up/config/constants/colors_const.dart';
import 'package:way_up/config/themes/text_theme.dart';

final CupertinoThemeData mainTheme = CupertinoThemeData(
    primaryColor: Colors.transparent,
    scaffoldBackgroundColor: AppColors.backGround,
    barBackgroundColor: AppColors.white,
    textTheme: CupertinoTextThemeData(
      textStyle: AppTextStyle.mainTextStyle1,
      actionTextStyle: AppTextStyle.actionTextStyle,
    ));
