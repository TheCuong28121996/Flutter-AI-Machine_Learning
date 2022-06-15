import 'package:flutter/material.dart';
import 'package:machine_learning/res/res.dart';

class BaseBottomSheet {
  BaseBottomSheet._internal();

  static final BaseBottomSheet _instance = BaseBottomSheet._internal();

  factory BaseBottomSheet() {
    return _instance;
  }

  void show({required BuildContext context, required Widget widget}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColor.backgroundCard,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        builder: (contextBottomSheet) => widget);
  }
}
