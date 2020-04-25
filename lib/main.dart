import 'package:flutter/material.dart';
import 'package:flutterchopper/app.dart';
import 'package:logging/logging.dart';

void main() {
_setupLogging();
  runApp(MyApp());
}

void _setupLogging() {
Logger.root.level=Level.ALL;
Logger.root.onRecord.listen((rec){
  print('${rec.level.name} : ${rec.time} : ${rec.message}');
});
}
