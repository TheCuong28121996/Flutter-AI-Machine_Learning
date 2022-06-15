import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machine_learning/base/base.dart';
import 'package:machine_learning/data/model/models.dart';
import 'package:machine_learning/res/res.dart';
import 'package:machine_learning/utils/utils.dart';
import 'package:machine_learning/widgets/widgets.dart';

import 'marvel_detection_bloc.dart';

class MarvelDetectionPage extends BasePage<MarvelDetectionBloc> {
  MarvelDetectionPage({Key? key})
      : super(key: key, bloc: MarvelDetectionBloc());
  static const routeName = '/FruitDetectionPage';

  @override
  State<StatefulWidget> createState() => _FruitDetectionPageState();
}

class _FruitDetectionPageState
    extends BasePageState<MarvelDetectionPage, MarvelDetectionBloc> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        showOnBack: true,
        titleWidget: const Text('Marvel Hero'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: () {
              getBloc.pickImage(ImageSource.camera);
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.photo),
        onPressed: () {
          getBloc.pickImage(ImageSource.gallery);
        },
        backgroundColor: AppColor.colorPrimary,
      ),
      body: SizedBox.expand(
        child: StreamBuilder<MarvelDetectionModel>(
            stream: getBloc.imageStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              return Stack(
                children: [
                  Image.file(
                    File(snapshot.data!.xFile.path),
                    height: 1.sh * 0.7,
                    width: 1.sw,
                  ),
                  Positioned(
                      bottom: 30.h,
                      left: 0,
                      right: 0,
                      child: Text(snapshot.data!.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white)))
                ],
              );
            }),
      ),
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
