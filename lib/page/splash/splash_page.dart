import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:machine_learning/base/base.dart';
import 'package:machine_learning/page/pages.dart';
import 'package:machine_learning/res/res.dart';
import 'package:machine_learning/utils/utils.dart';

class SplashPage extends BasePage {
  static const routeName = '/';

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends BasePageState<SplashPage, BaseBloc> {
  @override
  Widget buildWidget(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SvgPicture.asset(
            AssetImages.icMachineLearning,
            color: Colors.white,
            width: 150.w,
            height: 150.h,
          ),
        ),
      ),
    );
  }

  @override
  void onCreate() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    });
  }

  @override
  void onDestroy() {}
}
