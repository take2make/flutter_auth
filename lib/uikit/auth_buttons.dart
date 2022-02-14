import 'package:flutter/cupertino.dart';
import 'package:way_up/config/constants/colors_const.dart';

class Button extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  const Button({Key? key, required this.child, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: child,
          decoration: BoxDecoration(
            border:
                Border.all(width: 2, color: AppColors.white.withOpacity(0.5)),
            borderRadius: const BorderRadius.all(
              Radius.circular(32),
            ),
            color: AppColors.lightBlue,
          ),
        ),
        onPressed: onPressed);
  }
}
