import 'package:machine_learning/base/base_bloc.dart';
import 'package:machine_learning/data/model/models.dart';
import 'package:machine_learning/res/res.dart';
import 'package:machine_learning/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc {
  final _functionsSubject = BehaviorSubject<List<FunctionModel>>();

  Stream<List<FunctionModel>> get functionsStream => _functionsSubject.stream;

  final List<FunctionModel> _functions = [];

  @override
  void onCreate() {
    _functions.add(FunctionModel(
        id: Constants.tensorFlowId,
        name: Constants.tensorFlowName,
        image: AssetImages.tensorFlow));

    _functionsSubject.sink.add(_functions);
  }

  @override
  void dispose() {
    _functionsSubject.close();
  }
}
