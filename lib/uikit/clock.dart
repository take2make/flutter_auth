import 'package:flutter/cupertino.dart';

class ClockContainer extends StatefulWidget {
  const ClockContainer({Key? key}) : super(key: key);

  @override
  _ClockContainerState createState() => _ClockContainerState();
}

class _ClockContainerState extends State<ClockContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 245,
      height: 101,
      child: Row(
        children: [Container(), Container(), Container()],
      ),
    );
  }
}
