import 'package:flutter/foundation.dart';

void log(
  dynamic message, {
  String level = 'LOG',
}) {
  if (!kDebugMode) return;

  final output = '[$level] $message';

  debugPrint(output);
}
void logInfo(dynamic message) => log(message, level: 'INFO');
void logWarning(dynamic message) => log(message, level: 'WARN');
void logError(dynamic message) => log(message, level: 'ERROR');
void logSuccess(dynamic message) => log(message, level: 'SUCCESS');
