import 'package:flutter/widgets.dart';

/*
 Measure the width, height depend to your device
*/
class ScreenUtils {
  static double screenHeight(BuildContext context, {double percent}) {
    return MediaQuery.of(context).getHeight(percent: percent);
  }

  static double screenWidth(BuildContext context, {double percent}) {
    return MediaQuery.of(context).getWidth(percent: percent);
  }
}

extension on MediaQueryData {
  double getHeight({@required double percent}) {
    final heightInOnePercent = this.size.height * 1 / 100;
    return heightInOnePercent * (percent ?? 100);
  }

  double getWidth({@required double percent}) {
    final widthInOnePercent = this.size.width * 1 / 100;
    return widthInOnePercent * (percent ?? 100);
  }
}
