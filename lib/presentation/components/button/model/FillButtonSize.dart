import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Pair.dart';

class FillButtonSize {
  static const double _largeHeight = 60;
  static const double _largePaddingHorizontal = 50;

  static const double _normalHeight = 55;
  static const double _normalPaddingHorizontal = 50;

  static const double _smallHeight = 45;
  static const double _smallPaddingHorizontal = 50;

  static const double _xsmallHeight = 40;
  static const double _xsmallPaddingHorizontal = 56;

  /** 타입에 따른 버튼 패딩 반환 */
  static EdgeInsets getButtonPadding(ButtonSizeType type) {
    final Pair padding;

    switch (type) {
      case ButtonSizeType.Large:
        padding = FillButtonSize._getLargePadding();
        break;
      case ButtonSizeType.Normal:
        padding = FillButtonSize._getNormalPadding();
        break;
      case ButtonSizeType.Small:
        padding = FillButtonSize._getSmallPadding();
        break;
      case ButtonSizeType.XSmall:
        padding = FillButtonSize._getXSmallPadding();
        break;
    }

    return EdgeInsets.symmetric(
      vertical: padding.first,
      horizontal: padding.second,
    );
  }

  /** 타입에 따른 버튼 높이 반환 */
  static double getButtonHeight(ButtonSizeType type) {
    switch (type) {
      case ButtonSizeType.Large:
        return _largeHeight;
      case ButtonSizeType.Normal:
        return _normalHeight;
      case ButtonSizeType.Small:
        return _smallHeight;
      case ButtonSizeType.XSmall:
        return _xsmallHeight;
    }
  }

  static _getLargePadding() => Pair(
        0.0,
        FillButtonSize._largePaddingHorizontal,
      );

  static _getNormalPadding() => Pair(
        0.0,
        FillButtonSize._normalPaddingHorizontal,
      );

  static _getSmallPadding() => Pair(
    0.0,
        FillButtonSize._smallPaddingHorizontal,
      );

  static _getXSmallPadding() => Pair(
    0.0,
        FillButtonSize._xsmallPaddingHorizontal,
      );
}