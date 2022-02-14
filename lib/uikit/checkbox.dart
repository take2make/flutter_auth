import 'package:flutter/cupertino.dart';
import 'package:way_up/config/constants/colors_const.dart';

class AppCheckbox extends StatefulWidget {
  final bool isChecked;
  const AppCheckbox({Key? key, required this.isChecked}) : super(key: key);

  @override
  _AppCheckboxState createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      minSize: 0,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          border: Border.all(color: AppColors.mainGrey, width: 1),
          color: isChecked ? AppColors.mainGrey : null,
        ),
        child: isChecked
            ? Center(
                child: Icon(
                  CupertinoIcons.checkmark_alt,
                  size: 15,
                  color: AppColors.backGround,
                ),
              )
            : Container(),
      ),
    );
  }
}
