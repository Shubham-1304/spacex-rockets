import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:spacex_rockets/app/core/errors/exceptions.dart';
import 'package:spacex_rockets/app/modules/rockets/data/datasources/rocket_remote_datasource.dart';
import 'package:spacex_rockets/app/modules/rockets/data/models/rocket_model.dart';
import 'package:spacex_rockets/utils/urls.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late RocketRemoteDataSource dataSource;
  late http.Client client;
  final List<RocketModel> tRockets = [
    const RocketModel(
      id: "id1",
      name: "name1",
      country: "country1",
      costPerLaunch: 1092.20,
      description: "description1",
      diameterInFeet: 29.2,
      engineCount: 2,
      isActive: true,
      flickerImages: ["flickerImages1"],
      heightInFeet: 97.3,
      successRatePercent: 83.32,
      wikipediaLink: "wikipediaLink",
    ),
  ];
  setUp(() {
    client = MockClient();
    dataSource = RocketRemoteDataSourceImplementation(client);
    registerFallbackValue(Uri());
    // registerFallbackValue(Object());
  });

  group('getRockets', () {
    test('should complete successfully when the status code is 200', () async {
      when(
        () => client.get(any()),
      ).thenAnswer((_) async => http.Response(
          jsonEncode(
            [
              {
                "id": "id1",
                "name": "name1",
                "country": "country1",
                "cost_per_launch": 1092.20,
                "description": "description1",
                "diameter": {"feet": 29.2},
                "engines": {"number": 2},
                "flickr_images": ["flickerImages1"],
                "height": {"feet": 97.3},
                "success_rate_pct": 83.32,
                "wikipedia": "wikipedia_link",
                "active": true
              }
            ]
          ),
          200));

      final result = await dataSource.getRockets();

      expect(result, equals(tRockets));

      verify(
        () => client.get(
          Uri.https(Urls.baseURL, Urls.getRockets),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [APIException] when the status code is not 200',
        () async {
      when(
        () => client.get(any()),
      ).thenAnswer((_) async => http.Response("Something Went Wrong", 400));

      final result = dataSource.getRockets;

      expect(
          () => result(),
          throwsA(const APIException(
              message: "Something Went Wrong", statusCode: 400)));

      verify(
        () => client.get(
          Uri.https(Urls.baseURL, Urls.getRockets),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group('getRocketById', () {
    test('should complete successfully when the status code is 200', () async {
      when(
        () => client.get(any()),
      ).thenAnswer((_) async => http.Response(
          jsonEncode({
                "id": "id1",
                "name": "name1",
                "country": "country1",
                "cost_per_launch": 1092.20,
                "description": "description1",
                "diameter": {"feet": 29.2},
                "engines": {"number": 2},
                "flickr_images": ["flickerImages1"],
                "height": {"feet": 97.3},
                "success_rate_pct": 83.32,
                "wikipedia": "wikipedia_link",
                "active": true
              }),
          200));

      final result = await dataSource.getRocketById("id1");

      expect(result, equals(tRockets[0]));

      verify(
        () => client.get(
          Uri.https(Urls.baseURL, "${Urls.getRockets}/id1"),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [APIException] when the status code is not 200',
        () async {
      when(
        () => client.get(any()),
      ).thenAnswer((_) async => http.Response("Something Went Wrong", 400));

      final result = dataSource.getRocketById;

      expect(
          () => result("id1"),
          throwsA(const APIException(
              message: "Something Went Wrong", statusCode: 400)));

      verify(
        () => client.get(
          Uri.https(Urls.baseURL,"${Urls.getRockets}/id1"),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
