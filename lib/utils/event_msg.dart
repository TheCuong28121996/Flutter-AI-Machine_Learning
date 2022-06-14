class EventMsg {
  EventMsg({required this.type, required this.msg});

  final String type;
  final String msg;

  static const msgSuccess = 'msg_success';
  static const msgError = 'msg_error';
}