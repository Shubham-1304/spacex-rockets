import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spacex_rockets/app/core/services/injection_container.dart';
import 'package:spacex_rockets/app/modules/rockets/ui/blocs/cubit/rocket_by_id_cubit.dart';
import 'package:spacex_rockets/app/modules/rockets/ui/blocs/cubit/rocket_cubit.dart';
import 'package:spacex_rockets/app/modules/rockets/ui/screens/all_rockets_screen.dart';
import 'package:spacex_rockets/app/modules/rockets/ui/screens/rocket_detail_screen.dart';

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
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<RocketCubit>(),
            ),
            BlocProvider(
              create: (context) => sl<RocketByIdCubit>(),
            ),
          ],
          child: MaterialApp(
            title: 'SpaceX Rockets',
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
            debugShowCheckedModeBanner: false,
            home: AllRocketsScreen(),
            routes: {
              RocketDetailScreen.routeName: (context) =>
                  const RocketDetailScreen()
            },
          ),
        );
      },
    );
  }
}
