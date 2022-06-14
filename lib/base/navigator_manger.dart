import 'base_page.dart';

class NavigatorManger {
  final List<String> _activityStack = <String>[];

  NavigatorManger._internal();

  static final NavigatorManger _singleton = NavigatorManger._internal();

  factory NavigatorManger() => _singleton;

  void addWidget(BasePageState widgetName) {
    _activityStack.add(widgetName.getWidgetName());
  }

  void removeWidget(BasePageState widgetName) {
    _activityStack.remove(widgetName.getWidgetName());
  }

  bool isTopPage(BasePageState widgetName) {
    if (_activityStack.isEmpty) {
      return false;
    }
    try {
      return widgetName.getWidgetName() ==
          _activityStack[_activityStack.length - 1];
    } catch (exception) {
      return false;
    }
  }

  bool isSecondTop(BasePageState widgetName) {
    if (_activityStack.isEmpty) {
      return false;
    }
    try {
      return widgetName.getWidgetName() ==
          _activityStack[_activityStack.length - 2];
    } catch (exception) {
      return false;
    }
  }
}
