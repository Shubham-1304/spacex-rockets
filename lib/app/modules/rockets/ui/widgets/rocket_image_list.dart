import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spacex_rockets/app/modules/rockets/ui/blocs/cubit/rocket_by_id_cubit.dart';

class RocketImageList extends StatelessWidget {
  const RocketImageList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder <RocketByIdCubit, RocketByIdState>(
      builder: (context, state) {
        return Container(
          width: 0.9.sw,
          height: 0.6.sw,
          child: ListView.builder(
            itemCount: state is RocketByIdLoaded? state.rocket.flickerImages.length:2,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
              width: 0.8.sw,
              height: 0.6.sw,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    offset: Offset(1, 1),
                    blurRadius: 3,
                    spreadRadius: 4,
                    color: Colors.black.withOpacity(0.5))
              ]),
              child: CachedNetworkImage(
                imageUrl: state is RocketByIdLoaded ? state.rocket.flickerImages[index]:
                    "https://ivoice.live/wp-content/uploads/2019/12/no-image-1.jpg",
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error), // LOCAL IMAGE PLACEHOLDER FOR ERROR
                fadeOutDuration: const Duration(milliseconds: 300),
                fadeInDuration: const Duration(milliseconds: 300),
                useOldImageOnUrlChange: true,
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      },
    );
  }
}
