import 'package:flutter/cupertino.dart';
import 'package:way_up/config/constants/colors_const.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.horizontalRotatingDots(
        color: AppColors.white,
        size: 50,
      ),
    );
  }
}
