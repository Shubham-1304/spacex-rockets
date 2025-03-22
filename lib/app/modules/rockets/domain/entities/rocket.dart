import 'package:equatable/equatable.dart';

class Rocket extends Equatable {
  const Rocket({
    required this.id,
    required this.name,
    required this.country,
    required this.isActive,
    required this.costPerLaunch,
    required this.description,
    required this.diameterInFeet,
    required this.engineCount,
    required this.flickerImages,
    required this.heightInFeet,
    required this.successRatePercent,
    required this.wikipediaLink,
  });

  final String id;
  final String name;
  final String country;
  final int engineCount;
  final bool isActive;
  final List<String> flickerImages;
  final double costPerLaunch;
  final double successRatePercent;
  final String description;
  final String wikipediaLink;
  final double heightInFeet;
  final double diameterInFeet;


  @override
  List<Object?> get props => [id];
}
