import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_rockets/app/modules/rockets/ui/blocs/cubit/rocket_by_id_cubit.dart';
import 'package:spacex_rockets/utils/style_resources/styles.dart';

class RocketAppbar extends StatelessWidget {
  const RocketAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: RocketPersistentHeaderDelegate(),
      pinned: true,
    );
  }
}

class RocketPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: shrinkOffset > 0 ? 2 : 0,
      child: ClipRect(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Positioned(
                left: 40,
                right: 40,
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<RocketByIdCubit, RocketByIdState>(
                      builder: (context, state) {
                        return RichText(
                          text: TextSpan(
                            text: state is RocketByIdLoaded
                                ? state.rocket.name
                                : state is LoadingRocketById
                                    ? "Rocket Loading..."
                                    : "Error",
                            style: shrinkOffset > 0
                                ? Styles.boldStyleM
                                    .copyWith(color: Colors.black)
                                : Styles.boldStyleL
                                    .copyWith(color: Colors.black),
                          ),
                          overflow: TextOverflow.ellipsis,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                height: 30,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 50; // Maximum header height

  @override
  double get minExtent => 50; // Minimum header height

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
