import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    return SafeArea(
        child: Scaffold(
      appBar: const AppBarCustom(
        titleWidget: Text('Trang chủ'),
      ),
      body: SizedBox.expand(
        child: StreamBuilder<List<FunctionModel>>(
            initialData: [],
            stream: getBloc.functionsStream,
            builder: (context, snapshot) {
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: (1.sw / 2) / (1.sw / 1.85)),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return _gridViewBuilder(snapshot.data![index]);
                },
              );
            }),
      ),
    ));
  }

  Widget _gridViewBuilder(FunctionModel functionModel) {
    return GestureDetector(
        onTap: () async {
          //_changeModuleCatalogPage(module);
        },
        child: Card(
          color: AppColor.backgroundCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  functionModel.image,
                  color: Colors.white,
                  width: 80,
                  height: 80,
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Center(
                    child: Text(
                      functionModel.name.toUpperCase(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
