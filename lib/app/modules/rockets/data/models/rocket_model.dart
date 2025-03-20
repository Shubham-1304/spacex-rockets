import 'dart:convert';

import 'package:spacex_rockets/app/modules/rockets/domain/entities/rocket.dart';

class RocketModel extends Rocket {
  const RocketModel({
    required super.id,
    required super.name,
    required super.country,
    required super.costPerLaunch,
    required super.description,
    required super.diameterInMeter,
    required super.engineCount,
    required super.flickerImages,
    required super.heightInMeter,
    required super.successRatePercent,
    required super.wikipediaLink,
  });

  RocketModel copyWith({
    String? id,
    String? name,
    String? country,
    int? engineCount,
    List<String>? flickerImages,
    double? costPerLaunch,
    double? successRatePercent,
    String? description,
    String? wikipediaLink,
    double? heightInMeter,
    double? diameterInMeter,
  }) {
    return RocketModel(
        id: id ?? this.id,
        name: name ?? this.name,
        country: country ?? this.country,
        costPerLaunch: costPerLaunch ?? this.costPerLaunch,
        description: description ?? this.description,
        diameterInMeter: diameterInMeter ?? this.diameterInMeter,
        engineCount: engineCount ?? this.engineCount,
        flickerImages: flickerImages ?? this.flickerImages,
        heightInMeter: heightInMeter ?? this.heightInMeter,
        successRatePercent: successRatePercent ?? this.successRatePercent,
        wikipediaLink: wikipediaLink ?? this.wikipediaLink);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'country': country,
      'costPerLaunch': costPerLaunch,
      'description': description,
      'diameterInMeter': diameterInMeter,
      'engineCount': engineCount,
      'flickerImages': flickerImages,
      'heightInMeter': heightInMeter,
      'successRatePercent': successRatePercent,
      'wikipediaLink': wikipediaLink
    };
  }

  factory RocketModel.fromMap(Map<String, dynamic> map) {
    return RocketModel(
      id: map['id'] as String,
      name: map['name'] as String,
      country: map['country'] as String,
      costPerLaunch: double.parse(map['costPerLaunch'].toString()),
      description: map['description'] as String,
      diameterInMeter: double.parse(map['diameterInMeter'].toString()),
      engineCount: int.parse(map['engineCount'].toString()),
      flickerImages: List<String>.from((map['flickerImages'] as List)),
      heightInMeter: double.parse(map['heightInMeter'].toString()),
      successRatePercent: double.parse(map['successRatePercent'].toString()),
      wikipediaLink: map['wikipediaLink'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RocketModel.fromJson(String source) =>
      RocketModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory RocketModel.fromRocket(Rocket rocket) {
    return RocketModel(
      id: rocket.id,
      name: rocket.name,
      country: rocket.country,
      costPerLaunch: rocket.costPerLaunch,
      description: rocket.description,
      diameterInMeter: rocket.diameterInMeter,
      engineCount: rocket.engineCount,
      flickerImages: rocket.flickerImages,
      heightInMeter: rocket.heightInMeter,
      successRatePercent: rocket.successRatePercent,
      wikipediaLink: rocket.wikipediaLink,
    );
  }

  Rocket toEntityType() {
    return Rocket(
        id: id,
        name: name,
        country: country,
        costPerLaunch: costPerLaunch,
        description: description,
        diameterInMeter: diameterInMeter,
        engineCount: engineCount,
        flickerImages: flickerImages,
        heightInMeter: heightInMeter,
        successRatePercent: successRatePercent,
        wikipediaLink: wikipediaLink);
  }

  @override
  bool get stringify => true;
}
