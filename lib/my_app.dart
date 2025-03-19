import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        builder: (_, Widget? child) {
          return MaterialApp.router(
              title: 'SpaceX Rockets',
              theme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.light,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
              debugShowCheckedModeBanner: false,
          );
        },
    );
  }
}
