import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spacex_rockets/app/modules/rockets/ui/screens/rocket_detail_screen.dart';
import 'package:spacex_rockets/utils/style_resources/styles.dart';

class RocketCard extends StatelessWidget {
  const RocketCard({
    required this.id,
    required this.name,
    required this.country,
    required this.engines,
    this.imageUrl,
    super.key,
  });

  final String id;
  final String name;
  final String country;
  final int engines;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => RocketDetailScreen(id: id,), settings: const RouteSettings(name: RocketDetailScreen.routeName))),
      child: Container(
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
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: imageUrl ??
                    "https://ivoice.live/wp-content/uploads/2019/12/no-image-1.jpg",
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error), // LOCAL IMAGE PLACEHOLDER FOR ERROR
                fadeOutDuration: const Duration(milliseconds: 300),
                fadeInDuration: const Duration(milliseconds: 300),
                useOldImageOnUrlChange: true,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black87.withOpacity(0.5),
                    Colors.black38.withOpacity(0.4),
                    Colors.transparent
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Styles.boldStyleXXL.copyWith(color: Colors.white),
                  ),
                  Text(
                    "Country: $country",
                    overflow: TextOverflow.ellipsis,
                    style: Styles.semiBoldStyleM.copyWith(color: Colors.white),
                  ),
                  Text(
                    "Total Engines: $engines",
                    style: Styles.semiBoldStyleM.copyWith(color: Colors.white),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Tap for more info",
                      style: Styles.semiBoldStyleS.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
