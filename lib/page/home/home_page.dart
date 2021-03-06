import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:machine_learning/base/base.dart';
import 'package:machine_learning/data/model/models.dart';
import 'package:machine_learning/page/pages.dart';
import 'package:machine_learning/res/res.dart';
import 'package:machine_learning/utils/utils.dart';
import 'package:machine_learning/widgets/widgets.dart';

class HomePage extends BasePage<HomeBloc> {
  static const routeName = '/HomePage';

  HomePage({Key? key}) : super(key: key, bloc: HomeBloc());

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage, HomeBloc> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(
        titleWidget: Text('Trang chủ'),
      ),
      body: SizedBox.expand(
        child: StreamBuilder<List<FunctionModel>>(
            initialData: [],
            stream: getBloc.functionsStream,
            builder: (context, snapshot) {
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return _gridViewBuilder(snapshot.data![index]);
                },
              );
            }),
      ),
    );
  }

  Widget _gridViewBuilder(FunctionModel functionModel) {
    return InkWell(
        onTap: () {
          _onClickItem(functionModel);
        },
        child: Card(
          color: AppColor.backgroundCard,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SvgPicture.asset(functionModel.image,
                    color: AppColor.colorPrimary, width: 70, height: 70),
                const SizedBox(height: 8),
                Expanded(
                  child: Center(
                    child: Text(
                      functionModel.name.toUpperCase(),
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _onClickItem(FunctionModel func) {
    switch (func.id) {
      case Constants.marvelHeroDetectionId:
        Navigator.pushNamed(context, MarvelDetectionPage.routeName);
        break;
      default:
        break;
    }
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
