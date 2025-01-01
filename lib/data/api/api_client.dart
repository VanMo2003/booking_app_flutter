import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart' as Foundation;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as Http;

import '../../utils/app_constant.dart';
import '../models/response/api_response.dart';

class ApiClient extends GetxService {
  final String urlBase;
  final SharedPreferences sharedPreferences;
  static const String noInternetMessage = "";
  final int timeoutInSeconds = 90;

  String token = "";
  Map<String, String> _authHeaders = {};
  Map<String, String> _noAuthHeaders = {};

  ApiClient({required this.urlBase, required this.sharedPreferences}) {
    if (Foundation.kDebugMode) {
      log('Token: $token');
    }
    token = sharedPreferences.getString(AppConstant.TOKEN) ?? "";

    updateAuthHeader(token);
    updateNoAuthHeader();
  }

  void updateAuthHeader(
    String token,
  ) {
    Map<String, String> _header = {
      "Authorization": "Bearer $token",
      'content-type': 'application/json',
    };

    _authHeaders = _header;
  }

  void updateNoAuthHeader() {
    Map<String, String> _header = {
      'content-type': 'application/json',
    };
    _noAuthHeaders = _header;
  }

  Future<Response> getData(String uri,
      {Map<String, String>? query, Map<String, String>? header}) async {
    try {
      if (Foundation.kDebugMode) {
        debugPrint('====> Api Call : $uri\nHeader: $_authHeaders');
      }
      Http.Response response = await Http.get(
        Uri.parse(urlBase + uri).replace(queryParameters: query),
        headers: header ?? _authHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('Error : ${e.toString()}');
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getDataNoAuth(String uri,
      {Map<String, String>? query, Map<String, String>? header}) async {
    try {
      if (Foundation.kDebugMode) {
        debugPrint('====> Api Call : $uri\nHeader: $_authHeaders');
      }
      Http.Response response = await Http.get(
        Uri.parse(urlBase + uri).replace(queryParameters: query),
        headers: header ?? _noAuthHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('Error : ${e.toString()}');
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? header}) async {
    try {
      String requestBody = jsonEncode(body);
      if (Foundation.kDebugMode) {
        debugPrint('====> API Call : $uri\nHeader : ${header ?? _authHeaders}');
        debugPrint('====> API Body : $requestBody');
      }
      Http.Response response = await Http.post(
        Uri.parse(urlBase + uri),
        body: requestBody,
        headers: header ?? _authHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postDataNoAuth(String uri,
      {Map<String, String>? header, dynamic body}) async {
    try {
      String requestBody = jsonEncode(body ?? {"token": token});
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: ${header ?? _noAuthHeaders}');
        print('====> API Body: $requestBody}');
      }
      Http.Response _response = await Http.post(
        Uri.parse(urlBase + uri),
        body: requestBody,
        headers: header ?? _noAuthHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri,
      {dynamic body, Map<String, String>? header}) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: ${header ?? _authHeaders}');
        print('====> API Body: $body');
      }

      Http.Response _response = await Http.put(
        Uri.parse("$urlBase$uri"),
        body: jsonEncode(body),
        headers: header ?? _authHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri,
      {int? id, Map<String, String>? header}) async {
    try {
      if (Foundation.kDebugMode) {
        print(
            '====> API Call: $uri/${id ?? ""}\nHeader: ${header ?? _authHeaders}');
      }

      Http.Response _response = await Http.delete(
        Uri.parse(id != null ? "$urlBase$uri/$id" : "$urlBase$uri"),
        headers: header ?? _authHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(Http.Response response, String uri) {
    dynamic _body;
    try {
      if (response.body != "") {
        _body = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      }
    } catch (e) {
      // _body = jsonDecode(response.body);
      debugPrint('Error : ${e.toString()}');
    }
    Response _response = Response(
      body: _body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
        headers: response.request!.headers,
        method: response.request!.method,
        url: response.request!.url,
      ),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (_response.statusCode != 200 &&
        _response.body != null &&
        _response.body["message"] != null) {
      ApiResponse apiResponse = ApiResponse.fromJson(_response.body);
      _response = Response(
        statusCode: _response.statusCode,
        body: _response.body,
        statusText: apiResponse.message,
      );
    }
    if (Foundation.kDebugMode) {
      debugPrint('====> Api Response : [${_response.statusCode}] $uri');
    }
    return _response;
  }
}
