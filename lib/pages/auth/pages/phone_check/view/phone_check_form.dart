import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:way_up/config/constants/dictionary_const.dart';
import 'package:way_up/config/constants/icons_const.dart';
import 'package:way_up/config/constants/routes_const.dart';
import 'package:way_up/config/route_arguments/phone_check_arguments.dart';
import 'package:way_up/config/themes/text_theme.dart';
import 'package:way_up/pages/auth/pages/phone_check/bloc/phone_check_bloc.dart';

import 'package:way_up/uikit/auth_buttons.dart';
import 'package:way_up/uikit/input.dart';
import 'package:way_up/uikit/loader.dart';
import 'package:formz/formz.dart';

class PhoneCheckForm extends StatelessWidget {
  final PhoneCheckArguments phoneCheckArguments;
  PhoneCheckForm({Key? key, required this.phoneCheckArguments})
      : super(key: key);
  final TextEditingController controller = TextEditingController();

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
                      phoneCheckArguments.isRegistration
                          ? AppDictionary.register
                          : AppDictionary.recover,
                      style: AppTextStyle.mainTextStyle2,
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  _PhoneNumberInput(
                    phoneNumberController: controller,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  _RegisterButton(
                    phoneNumberController: controller,
                    isRegistration: phoneCheckArguments.isRegistration,
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  CupertinoButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(Routes.login, (_) => true);
                    },
                    padding: const EdgeInsets.all(0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppDictionary.alreadyHasAccount,
                              style: AppTextStyle.inputTextStyle4),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(AppDictionary.signIn,
                              style: AppTextStyle.inputTextStyleBlue),
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

class _PhoneNumberInput extends StatelessWidget {
  final TextEditingController phoneNumberController;
  const _PhoneNumberInput({Key? key, required this.phoneNumberController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneCheckBloc, PhoneCheckState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return Input(
          svgName: AppIcons.phoneIcon,
          iconWidth: 20,
          iconHeight: 20,
          inputFormatters: [
            MaskedInputFormatter("+#(###)###-##-##"),
          ],
          keyboardType: TextInputType.number,
          placeHolder: AppDictionary.phoneNumberPlaceHolder,
          controller: phoneNumberController,
          isIncorrect: state.phoneNumber.invalid,
          onChanged: (value) {
            context.read<PhoneCheckBloc>().add(PhoneNumberChanged(value));
          },
          description: state.phoneNumber.invalid
              ? AppDictionary.incorrectPhoneNumber
              : "",
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  final TextEditingController phoneNumberController;
  final bool isRegistration;
  const _RegisterButton(
      {Key? key,
      required this.phoneNumberController,
      required this.isRegistration})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneCheckBloc, PhoneCheckState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const Loader()
            : Button(
                child: Text(
                  isRegistration
                      ? AppDictionary.register
                      : AppDictionary.confirm,
                  style: AppTextStyle.mainTextStyle1,
                ),
                onPressed: () {
                  context
                      .read<PhoneCheckBloc>()
                      .add(PhoneNumberChanged(phoneNumberController.text));
                  if (isRegistration) {
                    context
                        .read<PhoneCheckBloc>()
                        .add(const RegisterSubmitted());
                  } else {
                    context
                        .read<PhoneCheckBloc>()
                        .add(const RestoreSubmitted());
                  }
                },
              );
      },
    );
  }
}
