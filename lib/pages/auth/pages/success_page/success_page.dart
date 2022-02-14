import 'package:flutter/cupertino.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:way_up/config/constants/colors_const.dart';
import 'package:way_up/config/constants/dictionary_const.dart';
import 'package:way_up/config/constants/icons_const.dart';
import 'package:way_up/config/constants/routes_const.dart';
import 'package:way_up/config/route_arguments/phone_check_arguments.dart';
import 'package:way_up/config/route_arguments/success_arguments.dart';
import 'package:way_up/config/themes/text_theme.dart';
import 'package:way_up/uikit/auth_buttons.dart';
import 'package:way_up/uikit/input.dart';

class SuccessPage extends StatelessWidget {
  final SuccessArguments successArguments;
  const SuccessPage({Key? key, required this.successArguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 29,
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  Center(
                    child: Text(
                      successArguments.isRegistration
                          ? AppDictionary.congratulations
                          : AppDictionary.confirmPhoneNumber,
                      style: AppTextStyle.mainTextStyle2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Input(
                    svgName: AppIcons.phoneIcon,
                    iconWidth: 20,
                    iconHeight: 20,
                    inputFormatters: [
                      MaskedInputFormatter("+#(###)###-##-##"),
                    ],
                    keyboardType: TextInputType.number,
                    placeHolder: successArguments.phoneNumber,
                    readOnly: true,
                    description: successArguments.isRegistration
                        ? AppDictionary.passwordSentSMS
                        : AppDictionary.newPasswordSent,
                  ),
                  const SizedBox(
                    height: 44,
                  ),
                  Container(
                    height: 150,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(28)),
                            color: AppColors.successGreen,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Spacer(),
                                Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  child: Icon(
                                    CupertinoIcons.location_circle,
                                    color: AppColors.successGreen2,
                                    size: 60,
                                  ),
                                ),
                              ],
                            ),
                            Icon(CupertinoIcons.lock_circle)
                          ],
                        ),
                        Center(
                          child: Text(
                            successArguments.isRegistration
                                ? AppDictionary.successRegistration
                                : AppDictionary.sucessRecover,
                            style: AppTextStyle.successTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Button(
                    child: Text(
                      AppDictionary.signIn,
                      style: AppTextStyle.mainTextStyle1,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(Routes.login, (_) => false);
                    },
                  ),
                  const SizedBox(
                    height: 34,
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppDictionary.noAccount,
                              style: AppTextStyle.inputTextStyle4),
                          const SizedBox(
                            width: 20,
                          ),
                          CupertinoButton(
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  Routes.phoneCheck, (_) => false,
                                  arguments: PhoneCheckArguments(
                                      isRegistration: true));
                            },
                            padding: const EdgeInsets.all(0),
                            child: Text(AppDictionary.register,
                                style: AppTextStyle.inputTextStyleBlue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
