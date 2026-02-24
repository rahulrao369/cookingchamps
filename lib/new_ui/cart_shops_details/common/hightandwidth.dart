import 'package:flutter/cupertino.dart';

class ScreenHeightSizedBox extends StatelessWidget {
  final double? heightPercent;
  final double? widthPercent;

  const ScreenHeightSizedBox({
    Key? key,
    this.heightPercent,
    this.widthPercent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = heightPercent != null ? screenSize.height * (heightPercent! / 100) : null;
    final width = widthPercent != null ? screenSize.width * (widthPercent! / 100) : null;

    return SizedBox(
      height: height,
      width: width,
    );
  }
}
