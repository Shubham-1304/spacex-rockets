import 'package:flutter/material.dart';
import 'package:spacex_rockets/app/modules/rockets/ui/widgets/rocket_list.dart';

class AllRocketsScreen extends StatelessWidget {
  const AllRocketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: RocketList()),
    );
  }
}
