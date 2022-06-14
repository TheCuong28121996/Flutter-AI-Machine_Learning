import 'dart:developer' as developer;

class DebugLog {
  DebugLog._();

  static void show(String? msg) {
    developer.log(msg ?? '', name: '${DateTime.now()} DevDebug:');
  }
}
