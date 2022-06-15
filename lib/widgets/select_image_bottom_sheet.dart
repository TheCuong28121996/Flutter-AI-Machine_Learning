import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:machine_learning/base/base.dart';
import 'package:machine_learning/res/res.dart';
import 'package:machine_learning/utils/utils.dart';

class SelectImageBottomSheet {
  SelectImageBottomSheet._internal();

  static final SelectImageBottomSheet _instance =
      SelectImageBottomSheet._internal();

  factory SelectImageBottomSheet() {
    return _instance;
  }

  void show(
      {required BuildContext context,
      required Function(SelectOptionImage) onSelect}) {
    BaseBottomSheet().show(
        context: context,
        widget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            headerWidget(context: context, title: 'Thêm hình ảnh/Video'),
            Divider(
              height: 1,
              color: AppColor.colorLine,
            ),
            SizedBox(height: 8.h),
            _itemSelect(
                title: 'Từ máy ảnh',
                image: AssetPath.iconOptionCamera,
                onTap: () {
                  Navigator.pop(context);
                  onSelect(SelectOptionImage.camera);
                }),
            Divider(color: AppColor.colorLine, height: 0, indent: 65.w),
            _itemSelect(
                title: 'Từ thư viện',
                image: AssetPath.iconOptionGallery,
                onTap: () {
                  Navigator.pop(context);
                  onSelect(SelectOptionImage.gallery);
                }),
            SizedBox(height: 8.h),
          ],
        ));
  }

  Widget _itemSelect(
      {required String title,
      required String image,
      required GestureTapCallback onTap}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: ListTile(
        leading: SvgPicture.asset(image),
        title: Text(title, style: TextStyle(fontSize: 14.sp)),
        onTap: () {
          onTap();
        },
      ),
    );
  }
}

Widget headerWidget({required BuildContext context, required String title}) {
  return Container(
    width: 1.sw,
    height: 40.h,
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    child: Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.close)),
        ),
        Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 16.sp),
          ),
        ),
      ],
    ),
  );
}

enum SelectOptionImage { camera, gallery }
