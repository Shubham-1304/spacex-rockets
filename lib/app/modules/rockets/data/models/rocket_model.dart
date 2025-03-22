import 'dart:convert';

import 'package:spacex_rockets/app/modules/rockets/domain/entities/rocket.dart';

class RocketModel extends Rocket {
  const RocketModel({
    required super.id,
    required super.name,
    required super.country,
    required super.costPerLaunch,
    required super.description,
    required super.diameterInFeet,
    required super.engineCount,
    required super.flickerImages,
    required super.isActive,
    required super.heightInFeet,
    required super.successRatePercent,
    required super.wikipediaLink,
  });

  RocketModel copyWith({
    String? id,
    String? name,
    String? country,
    int? engineCount,
    bool? isActive,
    List<String>? flickerImages,
    double? costPerLaunch,
    double? successRatePercent,
    String? description,
    String? wikipediaLink,
    double? heightInFeet,
    double? diameterInFeet,
  }) {
    return RocketModel(
        id: id ?? this.id,
        name: name ?? this.name,
        country: country ?? this.country,
        costPerLaunch: costPerLaunch ?? this.costPerLaunch,
        description: description ?? this.description,
        diameterInFeet: diameterInFeet ?? this.diameterInFeet,
        engineCount: engineCount ?? this.engineCount,
        flickerImages: flickerImages ?? this.flickerImages,
        isActive: isActive ?? this.isActive,
        heightInFeet: heightInFeet ?? this.heightInFeet,
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
      'diameterInFeet': diameterInFeet,
      'engineCount': engineCount,
      'flickerImages': flickerImages,
      'isActive': isActive,
      'heightInFeet': heightInFeet,
      'successRatePercent': successRatePercent,
      'wikipediaLink': wikipediaLink
    };
  }

  factory RocketModel.fromMap(Map<String, dynamic> map) {
    return RocketModel(
      id: map['id'] as String,
      name: map['name'] as String,
      country: map['country'] as String,
      costPerLaunch: double.tryParse(map['cost_per_launch'].toString()) ?? 0,
      description: map['description'] as String,
      diameterInFeet: double.tryParse(map['diameter']["feet"].toString()) ?? 0,
      engineCount: int.parse(map['engines']["number"].toString()),
      flickerImages: List<String>.from((map['flickr_images'] as List)),
      isActive: map['active'] as bool,
      heightInFeet: double.tryParse(map['height']["feet"].toString()) ?? 0,
      successRatePercent: double.tryParse(map['success_rate_pct'].toString()) ?? 0,
      wikipediaLink: map['wikipedia'] as String,
    );
  }

  factory RocketModel.fromLocalMap(Map<String, dynamic> map) {
    return RocketModel(
      id: map['id'] as String,
      name: map['name'] as String,
      country: map['country'] as String,
      costPerLaunch: double.tryParse(map['costPerLaunch'].toString()) ?? 0,
      description: map['description'] as String,
      diameterInFeet: double.tryParse(map['diameterInFeet'].toString()) ?? 0,
      engineCount: int.parse(map['engineCount'].toString()),
      flickerImages: List<String>.from((map['flickerImages'] as List)),
      isActive: map['isActive'] as bool,
      heightInFeet: double.tryParse(map['heightInFeet'].toString()) ?? 0,
      successRatePercent: double.tryParse(map['successRatePercent'].toString()) ?? 0,
      wikipediaLink: map['wikipediaLink'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RocketModel.fromJson(String source) =>
      RocketModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory RocketModel.fromLocalJson(String source) =>
      RocketModel.fromLocalMap(json.decode(source) as Map<String, dynamic>);

  factory RocketModel.fromRocket(Rocket rocket) {
    return RocketModel(
      id: rocket.id,
      name: rocket.name,
      country: rocket.country,
      costPerLaunch: rocket.costPerLaunch,
      description: rocket.description,
      diameterInFeet: rocket.diameterInFeet,
      engineCount: rocket.engineCount,
      flickerImages: rocket.flickerImages,
      isActive: rocket.isActive,
      heightInFeet: rocket.heightInFeet,
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
        diameterInFeet: diameterInFeet,
        engineCount: engineCount,
        flickerImages: flickerImages,
        isActive: isActive,
        heightInFeet: heightInFeet,
        successRatePercent: successRatePercent,
        wikipediaLink: wikipediaLink);
  }

  @override
  bool get stringify => true;
}
