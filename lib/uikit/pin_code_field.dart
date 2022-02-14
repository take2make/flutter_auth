import 'package:flutter/cupertino.dart';
import 'package:way_up/config/constants/colors_const.dart';
import 'package:way_up/config/themes/text_theme.dart';

class PinCodeField extends StatefulWidget {
  const PinCodeField({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.isIncorrect = false,
    this.description,
  }) : super(key: key);
  final TextEditingController controller;
  final void Function(String) onChanged;
  final bool? isIncorrect;
  final String? description;

  @override
  _PinCodeFieldState createState() => _PinCodeFieldState();
}

class CodeField {
  final FocusNode focusNode;
  final TextEditingController controller;
  CodeField({required this.focusNode, required this.controller});
}

class _PinCodeFieldState extends State<PinCodeField> {
  List<CodeField> codeFields = [];
  List<String> resultCode = [];
  int codeLength = 4;

  @override
  void initState() {
    for (int i = 0; i < codeLength; i++) {
      codeFields.add(
        CodeField(
          controller: TextEditingController(),
          focusNode: FocusNode(),
        ),
      );
    }
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    for (var codeField in codeFields) {
      codeField.controller.dispose();
      codeField.focusNode.dispose();
    }
    super.dispose();
  }

  String get codeValue {
    String _value = "";
    for (var codeField in codeFields) {
      _value += codeField.controller.text;
    }

    return _value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            for (int i = 0; i < codeLength; i++)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      Center(
                        child: CupertinoTextField(
                          focusNode: codeFields[i].focusNode,
                          controller: codeFields[i].controller,
                          decoration: const BoxDecoration(),
                          style:
                              widget.isIncorrect != null && widget.isIncorrect!
                                  ? AppTextStyle.inputErrorCodeStyle
                                  : AppTextStyle.inputCodeStyle,
                          cursorColor: AppColors.mainGrey,
                          maxLength: 1,
                          placeholderStyle: AppTextStyle.inputCodeStyle,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            if (text.isEmpty) {
                              if (i != 0) {
                                FocusScope.of(context)
                                    .requestFocus(codeFields[i - 1].focusNode);
                              }
                            } else {
                              if (i != codeLength - 1) {
                                FocusScope.of(context)
                                    .requestFocus(codeFields[i + 1].focusNode);
                              }
                            }
                            widget.controller.text = codeValue;
                            widget.onChanged(codeValue);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          color:
                              widget.isIncorrect != null && widget.isIncorrect!
                                  ? AppColors.errorRed
                                  : codeFields[i].controller.text.isNotEmpty
                                      ? AppColors.white
                                      : AppColors.buttonBlue02,
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
        const SizedBox(
          height: 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.description ?? "",
              style: widget.isIncorrect != null && widget.isIncorrect!
                  ? AppTextStyle.inputErrorSmallTextStyle
                  : AppTextStyle.inputSmallTextStyle,
            ),
          ],
        ),
      ],
    );
  }
}
