// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:home_rental/controller/API/custom_exceptions.dart';
import 'package:home_rental/models/response_handler.dart';
import 'package:http/http.dart' as http;

class BaseApi {
  final String baseApi = 'homeforrent.herokuapp.com';

  Future<ResponseHandler> get(
    BuildContext context,
    String url,
    Map<String, String> headers,
    bool showError,
    bool showLoading,
  ) async {
    if (showLoading) {
      if (!EasyLoading.isShow) {
        EasyLoading.show(status: '');
      }
    }

    var jsonResponse;
    try {
      final response =
          await http.get(Uri.https(baseApi, url), headers: headers);
      jsonResponse = _response(response, context);
      print(jsonResponse);
    } on SocketException {
      throw CommunicationException('No Internet');
    }

    if (showLoading) {
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    }

    return ResponseHandler.fromJson(jsonResponse);
  }

  dynamic _response(http.Response response, context) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;

      case 400:
        var responseJson = json.decode(response.body.toString());
        ResponseHandler responseHandler =
            ResponseHandler.fromJson(responseJson);
        if (EasyLoading.isShow) {
          EasyLoading.dismiss();
        }
        'Error';
        throw BadRequestException([responseHandler.message]);

      default:
        if (EasyLoading.isShow) {
          EasyLoading.dismiss();
        }

        throw CommunicationException(
            'Bad Communication' '${response.statusCode}');
    }
  }
}
