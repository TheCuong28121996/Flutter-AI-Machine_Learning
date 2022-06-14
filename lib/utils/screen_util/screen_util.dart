import 'dart:math';

import 'package:flutter/material.dart';

class ScreenUtil {
  static const Size defaultSize = Size(360, 690);
  static late ScreenUtil _instance;

  // Size of the phone in UI Design , dp
  late Size uiSize;

  late Orientation _orientation;

  late double _screenWidth;
  late double _screenHeight;
  late bool _minTextAdapt;
  late BuildContext? context;
  late bool _splitScreenMode;

  ScreenUtil._();

  factory ScreenUtil() {
    return _instance;
  }

  static void setContext(BuildContext context) {
    _instance.context = context;
  }

  static void init(
    BoxConstraints constraints, {
    BuildContext? context,
    Orientation orientation = Orientation.portrait,
    Size designSize = defaultSize,
    bool splitScreenMode = false,
    bool minTextAdapt = false,
  }) {
    _instance = ScreenUtil._()
      ..uiSize = designSize
      .._splitScreenMode = splitScreenMode
      .._minTextAdapt = minTextAdapt
      .._orientation = orientation
      .._screenWidth = constraints.maxWidth
      .._screenHeight = constraints.maxHeight;
    if (context != null) setContext(context);
  }

  //Get screen orientation
  Orientation get orientation => _orientation;

  // The number of font pixels for each logical pixel.
  double get textScaleFactor =>
      context != null ? MediaQuery.of(context!).textScaleFactor : 1;

  // The size of the media in logical pixels (e.g, the size of the screen).
  double? get pixelRatio =>
      context != null ? MediaQuery.of(context!).devicePixelRatio : 1;

  // The horizontal extent of this size.
  double get screenWidth =>
      context != null ? MediaQuery.of(context!).size.width : _screenWidth;

  //The vertical extent of this size. dp
  double get screenHeight =>
      context != null ? MediaQuery.of(context!).size.height : _screenHeight;

  // The offset from the top, in dp
  double get statusBarHeight =>
      context == null ? 0 : MediaQuery.of(context!).padding.top;

  // The offset from the bottom, in dp
  double get bottomBarHeight =>
      context == null ? 0 : MediaQuery.of(context!).padding.bottom;

  // The ratio of actual width to UI design
  double get scaleWidth => screenWidth / uiSize.width;

  double get scaleHeight =>
      (_splitScreenMode ? max(screenHeight, 700) : screenHeight) /
      uiSize.height;

  double get scaleText =>
      _minTextAdapt ? min(scaleWidth, scaleHeight) : scaleWidth;

  // Adapted to the device width of the UI Design.
  // Height can also be adapted according to this to ensure no deformation ,
  // if you want a square
  double setWidth(num width) => width * scaleWidth;

  // Highly adaptable to the device according to UI Design
  // It is recommended to use this method to achieve a high degree of adaptation
  // when it is found that one screen in the UI design
  // does not match the current style effect, or if there is a difference in shape.
  double setHeight(num height) => height * scaleHeight;

  //Adapt according to the smaller of width or height
  double radius(num r) => r * min(scaleWidth, scaleHeight);

  //Font size adaptation method
  //- [fontSize] The size of the font on the UI design, in dp.
  double setSp(num fontSize) => fontSize * scaleText;

  Widget setVerticalSpacing(num height) => SizedBox(height: setHeight(height));

  Widget setVerticalSpacingFromWidth(num height) =>
      SizedBox(height: setWidth(height));

  Widget setHorizontalSpacing(num width) => SizedBox(width: setWidth(width));

  Widget setHorizontalSpacingRadius(num width) =>
      SizedBox(width: radius(width));

  Widget setVerticalSpacingRadius(num height) =>
      SizedBox(height: radius(height));
}
