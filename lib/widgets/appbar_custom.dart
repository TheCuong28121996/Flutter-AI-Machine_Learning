import 'package:flutter/material.dart';
import 'package:machine_learning/res/res.dart';
import 'package:machine_learning/utils/utils.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom(
      {Key? key,
        this.leadingWidget,
        this.titleWidget,
        this.actions,
        this.showOnBack = false})
      : super(key: key);

  final Widget? leadingWidget;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final bool showOnBack;

  @override
  Size get preferredSize {
    return Size.fromHeight(56.h);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showOnBack,
      title: titleWidget,
      actions: actions,
      leading: leadingWidget,
      centerTitle: true,
      elevation: 1,
      shadowColor: AppColor.colorDefaultText,
    );
  }
}
