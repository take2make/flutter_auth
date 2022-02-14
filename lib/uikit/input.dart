import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:way_up/config/constants/colors_const.dart';
import 'package:way_up/config/themes/text_theme.dart';

class Input extends StatelessWidget {
  final String svgName;
  final double iconWidth;
  final double iconHeight;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? placeHolder;
  final TextEditingController? controller;
  final bool? isIncorrect;
  final String? text;
  final bool? readOnly;
  final String? description;
  final void Function(String)? onChanged;

  const Input({
    Key? key,
    required this.svgName,
    required this.iconHeight,
    required this.iconWidth,
    this.inputFormatters,
    this.obscureText,
    this.keyboardType,
    this.placeHolder,
    this.controller,
    this.isIncorrect,
    this.text,
    this.readOnly,
    this.description,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              CupertinoIcons.add,
              size: iconWidth,
              color: isIncorrect != null && isIncorrect!
                  ? AppColors.errorRed
                  : AppColors.mainGrey,
            ),
            Expanded(
              child: CupertinoTextField(
                decoration: const BoxDecoration(),
                padding: const EdgeInsets.only(left: 15),
                style: isIncorrect != null && isIncorrect!
                    ? AppTextStyle.inputErrorTextStyle
                    : AppTextStyle.inputTextStyle,
                cursorColor: AppColors.mainGrey,
                inputFormatters: inputFormatters,
                obscureText: obscureText ?? false,
                obscuringCharacter: '*',
                keyboardType: keyboardType,
                placeholder: placeHolder,
                placeholderStyle: readOnly != null && readOnly!
                    ? AppTextStyle.inputTextStyle
                    : isIncorrect != null && isIncorrect!
                        ? AppTextStyle.placeholderErrorTextStyle
                        : AppTextStyle.placeholderTextStyle,
                controller: controller,
                onChanged: onChanged,
                readOnly: readOnly ?? false,
              ),
            ),
          ],
        ),
        Divider(
          color: isIncorrect != null && isIncorrect!
              ? AppColors.errorRed
              : AppColors.mainGrey,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              description ?? "",
              style: isIncorrect != null && isIncorrect!
                  ? AppTextStyle.inputErrorSmallTextStyle
                  : AppTextStyle.inputSmallTextStyle,
            ),
          ],
        )
      ],
    );
  }
}
