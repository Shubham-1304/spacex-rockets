import 'package:flutter/material.dart';
import 'package:spacex_rockets/app/core/services/injection_container.dart';
import 'package:spacex_rockets/my_app.dart';

Future<void> main() async{
  await init();
  runApp(const MyApp());
}
