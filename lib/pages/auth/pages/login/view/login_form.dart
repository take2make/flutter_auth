import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:way_up/config/constants/dictionary_const.dart';
import 'package:way_up/config/constants/icons_const.dart';
import 'package:way_up/config/constants/routes_const.dart';
import 'package:way_up/config/route_arguments/phone_check_arguments.dart';
import 'package:way_up/config/themes/text_theme.dart';
import 'package:way_up/pages/auth/pages/login/bloc/login_bloc.dart';
import 'package:way_up/uikit/auth_buttons.dart';
import 'package:way_up/uikit/checkbox.dart';
import 'package:way_up/uikit/input.dart';
import "package:formz/formz.dart";
import 'package:way_up/uikit/loader.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                      AppDictionary.signIn,
                      style: AppTextStyle.mainTextStyle2,
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  _PhoneNumberInput(
                    phoneNumberController: phoneNumberController,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  _PasswordInput(
                    passwordController: passwordController,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      const AppCheckbox(isChecked: false),
                      const SizedBox(
                        width: 17,
                      ),
                      Text(AppDictionary.stayAuth,
                          style: AppTextStyle.inputTextStyle3)
                    ],
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppDictionary.forgetPassword,
                            style: AppTextStyle.inputTextStyle4),
                        const SizedBox(
                          width: 20,
                        ),
                        CupertinoButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                Routes.phoneCheck, (_) => false,
                                arguments:
                                    PhoneCheckArguments(isRegistration: false));
                          },
                          padding: const EdgeInsets.all(0),
                          child: Text(AppDictionary.recover,
                              style: AppTextStyle.inputTextStyleBlue),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  _LoginButton(
                    passwordController: passwordController,
                    phoneNumberController: phoneNumberController,
                  ),
                  const Spacer(),
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

class _PhoneNumberInput extends StatelessWidget {
  final TextEditingController phoneNumberController;
  const _PhoneNumberInput({Key? key, required this.phoneNumberController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
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
            context.read<LoginBloc>().add(LoginPhoneNumberChanged(value));
          },
          description: state.phoneNumber.invalid
              ? AppDictionary.incorrectPhoneNumber
              : "",
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final TextEditingController passwordController;
  const _PasswordInput({Key? key, required this.passwordController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Input(
          svgName: AppIcons.keyIcon,
          iconWidth: 22,
          iconHeight: 13,
          obscureText: true,
          placeHolder: AppDictionary.writePassword,
          controller: passwordController,
          isIncorrect: state.password.invalid,
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginPasswordChanged(value));
          },
          description:
              state.password.invalid ? AppDictionary.incorrectPassword : "",
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController phoneNumberController;
  const _LoginButton(
      {Key? key,
      required this.passwordController,
      required this.phoneNumberController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const Loader()
            : Button(
                child: Text(
                  AppDictionary.signIn,
                  style: AppTextStyle.mainTextStyle1,
                ),
                onPressed: () {
                  context
                      .read<LoginBloc>()
                      .add(LoginPasswordChanged(passwordController.text));
                  context
                      .read<LoginBloc>()
                      .add(LoginPhoneNumberChanged(phoneNumberController.text));
                  context.read<LoginBloc>().add(const LoginSubmitted());
                },
              );
      },
    );
  }
}
