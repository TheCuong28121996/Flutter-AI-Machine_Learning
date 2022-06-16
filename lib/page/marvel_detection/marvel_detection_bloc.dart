import 'package:image_picker/image_picker.dart';
import 'package:machine_learning/base/base_bloc.dart';
import 'package:machine_learning/data/model/models.dart';
import 'package:machine_learning/res/res.dart';
import 'package:machine_learning/utils/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tflite/tflite.dart';

class MarvelDetectionBloc extends BaseBloc {
  final _imageSubject = BehaviorSubject<MarvelDetectionModel>();

  Stream<MarvelDetectionModel> get imageStream => _imageSubject.stream;

  @override
  void onCreate() {
    _loadDataModel();
  }

  Future<void> _loadDataModel() async {
    String? _result = await Tflite.loadModel(
        model: AssetPath.modelMarvel,
        labels: AssetPath.labelsMarvel,
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false);

    DebugLog.show(_result);
  }

  Future<void> pickImage(ImageSource source) async {
    XFile? _xFile = await ImageUtils.pickImage(source);

    if (_xFile != null) {
      String _name = await _doImageClassification(_xFile.path);
      _imageSubject.sink.add(MarvelDetectionModel(xFile: _xFile, name: _name));
    }
  }

  Future<String> _doImageClassification(String path) async {
    String _result = '';
    var _recognitions = await Tflite.runModelOnImage(
        path: path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 1,
        threshold: 0.1,
        asynch: true);

    DebugLog.show(_recognitions!.length.toString());
    for (var element in _recognitions) {
      _result += element['label'] + '\n\n';
    }
    return _result;
  }

  @override
  void dispose() {
    _imageSubject.close();
  }
}
