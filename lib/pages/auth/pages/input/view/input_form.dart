import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_up/config/constants/colors_const.dart';
import 'package:way_up/config/constants/dictionary_const.dart';
import 'package:way_up/config/constants/icons_const.dart';
import 'package:way_up/config/constants/routes_const.dart';
import 'package:way_up/config/route_arguments/input_arguments.dart';
import 'package:way_up/config/route_arguments/phone_check_arguments.dart';
import 'package:way_up/config/routes/app_router.dart';
import 'package:way_up/config/themes/text_theme.dart';
import 'package:way_up/pages/auth/pages/input/bloc/input_bloc.dart';
import 'package:way_up/uikit/auth_buttons.dart';
import 'package:way_up/uikit/loader.dart';
import 'package:way_up/uikit/pin_code_field.dart';
import 'package:formz/formz.dart';

class InputForm extends StatelessWidget {
  final InputRouteArgumets inputArguments;

  InputForm({Key? key, required this.inputArguments}) : super(key: key);
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
                      AppDictionary.inputCode,
                      style: AppTextStyle.mainTextStyle2,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Center(
                    child: Text(
                      "${AppDictionary.codeSent} ${inputArguments.phoneNumber}",
                      style: AppTextStyle.inputTextStyle5,
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppDictionary.ifNotYou,
                          style: AppTextStyle.inputTextStyle5,
                        ),
                        CupertinoButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                Routes.phoneCheck, (_) => false,
                                arguments: PhoneCheckArguments(
                                    isRegistration: inputArguments.isRegister));
                          },
                          padding: const EdgeInsets.all(0),
                          minSize: 0,
                          child: Text(AppDictionary.write,
                              style: AppTextStyle.inputButtonTextStyle5),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    AppDictionary.correct,
                    style: AppTextStyle.inputTextStyle5,
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  _CodeInput(
                    controller: controller,
                  ),
                  const Spacer(),
                  CupertinoButton(
                    onPressed: () {},
                    padding: const EdgeInsets.all(0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppDictionary.codeDidNotCome,
                              style: AppTextStyle.inputTextStyle4),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(AppDictionary.sendCodeAgain,
                              style: AppTextStyle.inputTextStyleBlue),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  _InputButton(codeController: controller),
                  const SizedBox(
                    height: 51,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CupertinoButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      padding: const EdgeInsets.all(0),
                      child: Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.back,
                                color: AppColors.white,
                                size: 15,
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(AppDictionary.returnBack,
                                  style: AppTextStyle.mainTextStyle3),
                            ]),
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

class _CodeInput extends StatelessWidget {
  final TextEditingController controller;
  const _CodeInput({Key? key, required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputBloc, InputState>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        return Center(
          child: PinCodeField(
            controller: controller,
            isIncorrect: state.code.invalid,
            onChanged: (value) {
              context.read<InputBloc>().add(InputCodeChanged(value));
            },
            description: state.code.invalid ? AppDictionary.invalidCode : "",
          ),
        );
      },
    );
  }
}

class _InputButton extends StatelessWidget {
  final TextEditingController codeController;
  const _InputButton({
    Key? key,
    required this.codeController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputBloc, InputState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const Loader()
            : Button(
                child: Text(
                  AppDictionary.confirmPhoneNumber,
                  style: AppTextStyle.mainTextStyle1,
                ),
                onPressed: () {
                  context
                      .read<InputBloc>()
                      .add(InputCodeChanged(codeController.text));
                  context.read<InputBloc>().add(const InputCodeSubmitted());
                },
              );
      },
    );
  }
}
