import 'package:equatable/equatable.dart';

class Rocket extends Equatable {
  const Rocket({
    required this.id,
    required this.name,
    required this.country,
    required this.costPerLaunch,
    required this.description,
    required this.diameterInMeter,
    required this.engineCount,
    required this.flickerImages,
    required this.heightInMeter,
    required this.successRatePercent,
    required this.wikipediaLink,
  });

  final String id;
  final String name;
  final String country;
  final int engineCount;
  final List<String> flickerImages;
  final double costPerLaunch;
  final double successRatePercent;
  final String description;
  final String wikipediaLink;
  final double heightInMeter;
  final double diameterInMeter;


  @override
  List<Object?> get props => [id];
}
