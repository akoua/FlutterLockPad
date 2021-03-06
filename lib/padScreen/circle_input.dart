import 'package:flutter/material.dart';

@immutable
class CircleInputConfig {
  final Color borderColor;
  final Color fillColor;
  final double borderWidth;
  final double circleSize;

  const CircleInputConfig(
      {this.borderColor = Colors.white,
      this.borderWidth = 1,
      this.fillColor = Colors.white,
      this.circleSize = 20});
}

class CircleInput extends StatelessWidget {
  final bool filled;
  final CircleInputConfig circleUIConfig;
  double extraSize = 5;

  CircleInput(
      {Key key,
      this.filled = false,
      @required this.circleUIConfig,
      this.extraSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(
      //   top: extraSize,
      // ),
      margin: EdgeInsets.symmetric(
        horizontal: extraSize,
      ),
      width: circleUIConfig.circleSize,
      height: circleUIConfig.circleSize,
      decoration: BoxDecoration(
          color: filled ? circleUIConfig.fillColor : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
              color: circleUIConfig.borderColor,
              width: circleUIConfig.borderWidth)),
    );
  }
}
