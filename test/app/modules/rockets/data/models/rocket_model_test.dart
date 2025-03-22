import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:spacex_rockets/app/core/typedef.dart';
import 'package:spacex_rockets/app/modules/rockets/data/models/rocket_model.dart';
import 'package:spacex_rockets/app/modules/rockets/domain/entities/rocket.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = RocketModel(
      id: "id1",
      name: "rocketTest",
      country: "India",
      costPerLaunch: 100000,
      description: "rocket description",
      diameterInFeet: 19.2,
      engineCount: 4,
      isActive: true,
      flickerImages: ["https://flickerImages-test.com"],
      heightInFeet: 82.4,
      successRatePercent: 99.2,
      wikipediaLink: "https://example.com");

  test("should be [Rocket] entity", () {
    expect(tModel, isA<Rocket>());
  });

  final tJson = fixture('rocket.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group("copywith", () {
    test('should return [RocketModel] with right data', () {
      const newName = "test_update";
      final rocket = tModel.copyWith(name: newName);

      expect(rocket.name, newName);
    });
  });

  group('toMap', () {
    test('should return a map of type [DataMap]', () {
      final DataMap map = tModel.toMap();

      expect(map, tMap);
    });
  });

  group('fromMap', () {
    test('should return [RocketModel] with right data', () {
      expect(tModel == RocketModel.fromMap(tMap), true);
    });
  });

  group('toJson', () {
    test('should return json with right data', () {
      final data = tModel.toJson();
      final tJson = jsonEncode({
        "id": "id1",
        "name": "rocketTest",
        "country": "India",
        "costPerLaunch": 100000.0,
        "description": "rocket description",
        "diameterInFeet": 19.2,
        "engineCount": 4,
        "flickerImages": ["https://flickerImages-test.com"],
        "isActive": true,
        "heightInFeet": 82.4,
        "successRatePercent": 99.2,
        "wikipediaLink": "https://example.com"
      });
      expect(data, equals(tJson));
    });
  });

}
