// ResponseHandler welcomeFromJson(String str) =>
//     ResponseHandler.fromJson(json.decode(str));

// String welcomeToJson(ResponseHandler data) => json.encode(data.toJson());

import 'package:home_rental/models/allposts_model.dart';

class ResponseHandler {
  ResponseHandler({
    this.message,
    required this.users,
  });

  String? message;
  // List<UserDetailsModel>? users;
  dynamic users;

  factory ResponseHandler.fromJson(Map<String, dynamic> json) =>
      ResponseHandler(
        message: json["message"],
        users: json['users'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "users": users,
      };
}
