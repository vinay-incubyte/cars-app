import 'dart:developer' as dev;

abstract class Logger {
  void debugLog(Object? msg);
}

mixin class LoggerMixin implements Logger {
  @override
  void debugLog(Object? msg) => dev.log(msg.toString());
}
