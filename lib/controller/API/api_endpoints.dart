import 'package:flutter/cupertino.dart';
import 'package:home_rental/controller/API/api_base.dart';
import 'package:home_rental/models/response_handler.dart';

class ApiEndpoints {
  BaseApi baseApi = BaseApi();

  Future<ResponseHandler> getAllUsersPosts(
      {required BuildContext? context, required bool showLoading}) async {
    return baseApi.get(context!, 'api/getallposts/', {}, true, showLoading);
  }
}
