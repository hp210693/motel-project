/*MIT License

Copyright (c) 2023 Hung Phan (@hp210693)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.*/
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:motel/api/api_endpoints.dart';
import 'package:motel/api/base_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NetworkApiService extends BaseApiService {
  static const int _timeOut = 30;
  @override
  Future<dynamic> getLoginResponse(String userName, String passWord) async {
    try {
      final url = ApiEndPoints().loginUrl(userName, passWord);
      final query = {
        'user_name': userName,
        'password': passWord,
      };

      final resp = http.Request(
        'GET',
        Uri.parse(url),
      )..headers.addAll(
          {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        );

      resp.body = json.encode(query);
      final response = await resp.send();

      log("NetworkApiService - getLoginResponse - url = $resp");
      if (response.statusCode == 200) {
        return await response.stream.bytesToString();
      } else {
        return Exception("error");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getHomeResponse(String _) async {
    try {
      final url = ApiEndPoints().roomsUrl();
      log("NetworkApiService - getLoginResponse - url = $url");
      final resp = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: _timeOut));

      if (resp.statusCode == 200) {
        return resp.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getReportResponse(String _) async {
    try {
      final url = ApiEndPoints().reportsUrl();
      log("NetworkApiService - getReportResponse - url = $url");

      final prefs = await SharedPreferences.getInstance();
      var accessToken = prefs.getString("access_token");


      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        },
      );
/*       final resp = jsonDecode(response.body) as Map<String, dynamic>;

      log("NetworkApiService - getReportResponse - url = $resp"); */
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return Exception("error");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future postSignUpNewAccount(dynamic account) async {
    try {
      final url = ApiEndPoints().signUpUrl();
      log("NetworkApiService - postSignUpNewAccount - url = $url");
      final resp = await http
          .post(
            Uri.parse(url),
            body: jsonEncode(account),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            encoding: Encoding.getByName("utf-8"),
          )
          .timeout(const Duration(seconds: _timeOut));

      if (resp.statusCode == 200) return resp.body;
    } catch (e) {
      rethrow;
    }
  }
}
