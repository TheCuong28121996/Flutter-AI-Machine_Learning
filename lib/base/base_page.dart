import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:machine_learning/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

import 'base.dart';

abstract class BasePage<B extends BaseBloc> extends StatefulWidget {
  const BasePage({Key? key, this.bloc}) : super(key: key);

  final B? bloc;
}

abstract class BasePageState<Page extends BasePage, B extends BaseBloc?>
    extends State<Page> with WidgetsBindingObserver, BaseWidgetLifeCycle {

  final FToast _fToast = FToast();
  bool _onResumed = false;
  bool _onPause = false;
  bool _isShowLoading = false;
  late B? _bloc;

  B get getBloc => _bloc!;

  @mustCallSuper
  @override
  void initState() {
    NavigatorManger().addWidget(this);
    WidgetsBinding.instance?.addObserver(this);
    _bloc = widget.bloc as B?;
    onCreate();
    _observerBloc();
    super.initState();
  }

  @mustCallSuper
  @override
  void dispose() {
    onDestroy();
    WidgetsBinding.instance?.removeObserver(this);
    NavigatorManger().removeWidget(this);
    widget.bloc?.dispose();
    widget.bloc?.onDestroy();
    super.dispose();
  }

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    if (!_onResumed) {
      if (NavigatorManger().isTopPage(this)) {
        _onResumed = true;
        onResume();
      }
    }
    return Stack(
      children: [
        buildWidget(context),
        StreamBuilder<bool?>(
            initialData: false,
            stream: widget.bloc?.loadingStream,
            builder: (context, snapshot) {
              _isShowLoading = snapshot.data ?? false;
              return Visibility(
                  visible: _isShowLoading,
                  child: Center(
                      child: SizedBox(
                          width: 80.w,
                          height: 80.h,
                          child: Lottie.asset(Constants.loadingLottie))));
            })
      ],
    );
  }

  Widget buildWidget(BuildContext context);

  @mustCallSuper
  @override
  void deactivate() {
    if (NavigatorManger().isSecondTop(this)) {
      if (!_onPause) {
        onPause();
        _onPause = true;
      } else {
        onResume();
        _onPause = false;
      }
    } else if (NavigatorManger().isTopPage(this)) {
      if (!_onPause) {
        onPause();
      }
    }
    super.deactivate();
  }

  @mustCallSuper
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (NavigatorManger().isTopPage(this)) {
        onForeground();
        onResume();
      }
    } else if (state == AppLifecycleState.paused) {
      if (NavigatorManger().isTopPage(this)) {
        onBackground();
        onPause();
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  void _observerBloc() {
    widget.bloc?.onCreate();

    widget.bloc?.msgStream
        .transform(ThrottleStreamTransformer(
            (_) => TimerStream(true, const Duration(seconds: 2))))
        .listen((msg) => showToast(msg));
  }

  void showToast(EventMsg event) {
    _fToast.init(context);
    Widget toast = Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color:
                (event.type == EventMsg.msgError) ? Colors.red : Colors.green),
        child: Text(event.msg,
            style: TextStyle(color: Colors.white, fontSize: 20.sp),
            textAlign: TextAlign.center));

    _fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 2),
    );
  }

  String getWidgetName() {
    String className = context.toString();
    try {
      className = className.substring(0, className.indexOf("("));
    } catch (err) {
      className = "";
    }
    return className;
  }
}
