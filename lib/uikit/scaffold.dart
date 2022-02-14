import 'package:flutter/cupertino.dart';
import 'package:way_up/config/constants/colors_const.dart';
import 'package:way_up/config/themes/main_theme.dart';

/// Кастомизированный скаффолд
///
/// [leading] - кнопка слева от title
///
/// [leadingOnPressed] - действие при клике по [leading]
///
/// [action] - кнопка справа от title
///
/// [actionOnPressed] - действие при клике по [action]
///
class DefaultScaffold extends StatelessWidget {
  const DefaultScaffold({
    Key? key,
    required this.body,
    this.leading,
    this.action,
    this.leadingOnPressed,
    this.actionOnPressed,
    required this.title,
  }) : super(key: key);
  final Widget body;
  final Widget? leading;
  final Widget? action;
  final String title;
  final VoidCallback? leadingOnPressed;
  final VoidCallback? actionOnPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 28,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: leadingOnPressed,
                      child: Container(
                        color: AppColors.transparent,
                        height: 52,
                        width: 52,
                        child: Center(
                          child: SizedBox(
                            height: 17,
                            width: 9,
                            child: Center(child: leading),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      title,
                      style: mainTheme.textTheme.textStyle,
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    GestureDetector(
                      onTap: actionOnPressed,
                      child: SizedBox(
                        height: 52,
                        width: 52,
                        child: Center(
                          child: SizedBox(
                            height: 17,
                            width: 9,
                            child: Center(child: action),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(child: body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
