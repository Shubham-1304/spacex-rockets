import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spacex_rockets/app/core/errors/exceptions.dart';
import 'package:spacex_rockets/app/modules/rockets/data/models/rocket_model.dart';
import 'package:spacex_rockets/utils/urls.dart';

abstract class RocketRemoteDataSource {
  Future<List<RocketModel>> getRockets();
  Future<RocketModel> getRocketById(String id);
}

class RocketRemoteDataSourceImplementation implements RocketRemoteDataSource{
  const RocketRemoteDataSourceImplementation(this._client);

  final http.Client _client;

  @override
  Future<List<RocketModel>> getRockets() async{
    print("LIST API CALLED");
    try {
      final response = await _client.get(
        Uri.https(
          Urls.baseURL,
          Urls.getRockets,
        ),
      );
      if (response.statusCode != 200) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      final data = jsonDecode(response.body);
      final rockets = (data as List)
          .map((rocket) => RocketModel.fromMap(rocket))
          .toList();

      return rockets;
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<RocketModel> getRocketById(String id) async{
    print("DETAIL API CALLED");
    try {
      final response = await _client.get(
        Uri.https(
          Urls.baseURL,
          "${Urls.getRockets}/$id",
        ),
      );
      if (response.statusCode != 200) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      final data = jsonDecode(response.body);
      final rocket = RocketModel.fromMap(data);

      return rocket;
    } on APIException {
      rethrow;
    } catch (e) {
      // print(e.toString());
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

} 