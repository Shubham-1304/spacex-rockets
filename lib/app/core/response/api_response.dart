import 'package:equatable/equatable.dart';

class APIResponse extends Equatable{
  const APIResponse({
    required this.message,
    required this.statusCode,
    this.data= const {},
  });

  final String message;
  final int statusCode;
  final Map<String,dynamic> data;


  factory APIResponse.fromMap(Map<String, dynamic> map) {
    return APIResponse(
      message: map["message"],
      statusCode: map["status_code"],
      data: map.containsKey("data") ? map["data"]: {}
    );
  }

  @override
  List<Object?> get props => [message,statusCode];
}