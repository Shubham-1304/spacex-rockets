import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_rockets/app/modules/rockets/ui/blocs/cubit/rocket_by_id_cubit.dart';
import 'package:spacex_rockets/app/modules/rockets/ui/widgets/retry_widget.dart';
import 'package:spacex_rockets/app/modules/rockets/ui/widgets/rocket_appbar.dart';
import 'package:spacex_rockets/app/modules/rockets/ui/widgets/rocket_image_list.dart';
import 'package:spacex_rockets/utils/style_resources/styles.dart';

class RocketDetailScreen extends StatefulWidget {
  const RocketDetailScreen({this.id, super.key});
  static const String routeName = '/rocketDetail';

  final String? id;

  @override
  State<RocketDetailScreen> createState() => _RocketDetailScreenState();
}

class _RocketDetailScreenState extends State<RocketDetailScreen> {
  late RocketByIdCubit rocketCubit;

  @override
  void initState() {
    super.initState();
    rocketCubit = context.read<RocketByIdCubit>();
    rocketCubit.getRocketById(widget.id!);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    rocketCubit = context.read<RocketByIdCubit>();
  }

  @override
  void dispose() {
    rocketCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocConsumer<RocketByIdCubit, RocketByIdState>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state) {
            case RocketByIdLoaded():
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomScrollView(
                  slivers: [
                    const RocketAppbar(),
                    const SliverToBoxAdapter(
                      child: RocketImageList(),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        "Active: ${state.rocket.isActive}",
                        softWrap: true,
                        style:
                            Styles.semiBoldStyleM.copyWith(color: Colors.black),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        "Cost Per Launch: \$${state.rocket.costPerLaunch.truncate()}",
                        softWrap: true,
                        style:
                            Styles.semiBoldStyleM.copyWith(color: Colors.black),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        "Success Rate Percent: ${state.rocket.successRatePercent}%",
                        softWrap: true,
                        style:
                            Styles.semiBoldStyleM.copyWith(color: Colors.black),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: RichText(
                        softWrap: true,
                        text: TextSpan(
                            text: "Description: ",
                            style: Styles.semiBoldStyleM
                                .copyWith(color: Colors.black),
                            children: [
                              TextSpan(
                                text: state.rocket.description,
                                style: Styles.regularStyleM
                                    .copyWith(color: Colors.black),
                              ),
                            ]),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: RichText(
                          softWrap: true,
                          text: TextSpan(
                              text: "Wikipedia Link: ",
                              style: Styles.semiBoldStyleM
                                  .copyWith(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: state.rocket.wikipediaLink,
                                  style: Styles.regularStyleM
                                      .copyWith(color: Colors.blue),
                                ),
                              ]),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        "Height: ${state.rocket.heightInFeet} ft",
                        softWrap: true,
                        style:
                            Styles.semiBoldStyleM.copyWith(color: Colors.black),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        "Diameter: ${state.rocket.diameterInFeet} ft",
                        softWrap: true,
                        style:
                            Styles.semiBoldStyleM.copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              );
            case RocketByIdLoadError():
              return RetryWidget(message: state.message, retryFunction: ()=> rocketCubit.getRocketById(widget.id!));
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      )),
    );
  }
}
