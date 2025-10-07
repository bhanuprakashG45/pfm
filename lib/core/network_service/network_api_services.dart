import 'package:http/http.dart' as http;
import 'package:priya_fresh_meats/utils/exports.dart';

class NetworkApiServices extends BaseApiServices {
  final SharedPref _sharedPref = SharedPref();

  Future<void> _refreshAccessToken() async {
    final refreshToken = await _sharedPref.getRefreshToken();

    final response = await http.post(
      Uri.parse(AppUrls.refreshToken),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccessToken = data['data']['accessToken'];
      final newRefreshToken = data['data']['refreshToken'];

      await _sharedPref.storeAccessToken(newAccessToken);
      await _sharedPref.storeRefreshToken(newRefreshToken);
    } else {
      await _sharedPref.clearAccessToken();
      await _sharedPref.clearRefreshToken();
      if (response.statusCode == 403) {
        await _sharedPref.clearUserdata();
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          AppRoutes.login,
          (Route<dynamic> route) => false,
        );
      }

      throw UnauthorizedException("Unable to refresh token");
    }
  }

  @override
  Future<dynamic> getApiResponse(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    int retryCount = 0,
  }) async {
    try {
      String token = await _sharedPref.getAccessToken();
      final Map<String, String> finalHeaders = {
        'Authorization': 'Bearer $token',
        ...?headers,
      };
      final response = await http.get(Uri.parse(url), headers: finalHeaders);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    } on UnauthorizedException {
      if (retryCount < 1) {
        await _refreshAccessToken();
        return getApiResponse(
          url,
          headers: headers,
          body: body,
          retryCount: retryCount + 1,
        );
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> postApiResponse(
    String url,
    dynamic data, {
    Map<String, String>? headers,
    List<XFile>? images,
    int retryCount = 0,
  }) async {
    try {
      String token = await _sharedPref.getAccessToken();
      final Map<String, String> finalHeaders = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        ...?headers,
      };

      if (images != null && images.isNotEmpty) {
        var request = http.MultipartRequest("POST", Uri.parse(url));
        if (data != null) {
          if (data is Map<String, dynamic>) {
            data.forEach((key, value) {
              request.fields[key] = value.toString();
            });
          } else if (data is String) {
            Map<String, dynamic> data1 = json.decode(data);
            data1.forEach((key, value) {
              request.fields[key] = value.toString();
            });
          }
        }
        request.headers.addAll({'Authorization': 'Bearer $token'});
        for (var image in images) {
          request.files.add(
            await http.MultipartFile.fromPath('image', image.path),
          );
        }

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);
        return _processResponse(response);
      } else {
        final response = await http.post(
          Uri.parse(url),
          body: jsonEncode(data),
          headers: finalHeaders,
        );
        return _processResponse(response);
      }
    } on SocketException {
      throw FetchDataException("No Internet connection");
    } on UnauthorizedException {
      if (retryCount < 1) {
        await _refreshAccessToken();
        return postApiResponse(
          url,
          data,
          headers: headers,
          images: images,
          retryCount: retryCount + 1,
        );
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> putApiResponse(
    String url,
    dynamic data, {
    Map<String, String>? headers,
    List<XFile>? images,
    int retryCount = 0,
  }) async {
    try {
      String token = await _sharedPref.getAccessToken();
      Map<String, String> finalHeaders = {
        'Authorization': 'Bearer $token',
        ...?headers,
      };
      if (images != null && images.isNotEmpty) {
        var request = http.Request("PUT", Uri.parse(url));
        request.headers.addAll(finalHeaders);

        if (data != null) {
          String jsonData = jsonEncode(data);
          request.body = jsonData;
        }

        final response = await http.Response.fromStream(await request.send());
        return _processResponse(response);
      } else {
        final response = await http.put(
          Uri.parse(url),
          body: jsonEncode(data),
          headers: finalHeaders,
        );
        return _processResponse(response);
      }
    } on SocketException {
      throw FetchDataException("No Internet connection");
    } on UnauthorizedException {
      if (retryCount < 1) {
        await _refreshAccessToken();
        return putApiResponse(
          url,
          data,
          headers: headers,
          images: images,
          retryCount: retryCount + 1,
        );
      } else {
        rethrow;
      }
    }
  }

  Future<dynamic> patchApiResponse(
    String url,
    dynamic data, {
    Map<String, String>? headers,
    List<XFile>? images,
    int retryCount = 0,
  }) async {
    try {
      String token = await _sharedPref.getAccessToken();
      Map<String, String> requestHeaders = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        if (headers != null) ...headers,
      };

      if (images != null && images.isNotEmpty) {
        var request = http.MultipartRequest("PATCH", Uri.parse(url));
        request.headers.addAll(requestHeaders);

        if (data != null) {
          if (data is Map<String, dynamic>) {
            data.forEach((key, value) {
              request.fields[key] = value.toString();
            });
          } else if (data is String) {
            Map<String, dynamic> dataMap = json.decode(data);
            dataMap.forEach((key, value) {
              request.fields[key] = value.toString();
            });
          }
        }

        for (var image in images) {
          request.files.add(
            await http.MultipartFile.fromPath('image', image.path),
          );
        }
        final response = await http.Response.fromStream(await request.send());

        return await _processResponse(response);
      } else {
        final response = await http.patch(
          Uri.parse(url),
          body: jsonEncode(data),
          headers: requestHeaders,
        );
        return _processResponse(response);
      }
    } on SocketException {
      throw FetchDataException("No Internet connection");
    } on UnauthorizedException {
      if (retryCount < 1) {
        await _refreshAccessToken();
        return patchApiResponse(
          url,
          data,
          headers: headers,
          images: images,
          retryCount: retryCount + 1,
        );
      } else {
        rethrow;
      }
    }
  }

  Future<dynamic> deleteApiResponse(
    String url, {
    Map<String, String>? headers,
    dynamic data,
    List<XFile>? images,
    int retryCount = 0,
  }) async {
    try {
      String token = await _sharedPref.getAccessToken();
      Map<String, String> requestHeaders = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        if (headers != null) ...headers,
      };

      if (images != null && images.isNotEmpty) {
        var request = http.MultipartRequest("DELETE", Uri.parse(url));
        request.headers.addAll(requestHeaders);
        if (data != null) {
          if (data is Map<String, dynamic>) {
            data.forEach((key, value) {
              request.fields[key] = value.toString();
            });
          } else if (data is String) {
            Map<String, dynamic> dataMap = json.decode(data);
            dataMap.forEach((key, value) {
              request.fields[key] = value.toString();
            });
          }
        }

        for (var image in images) {
          request.files.add(
            await http.MultipartFile.fromPath('image', image.path),
          );
        }

        final response = await http.Response.fromStream(await request.send());

        return await _processResponse(response);
      } else {
        debugPrint(data);
        final response = await http.delete(
          Uri.parse(url),
          headers: requestHeaders,
          body: data != null ? jsonEncode(data) : null,
        );
        return _processResponse(response);
      }
    } on SocketException {
      throw FetchDataException("No Internet connection");
    } on UnauthorizedException {
      if (retryCount < 1) {
        await _refreshAccessToken();
        return deleteApiResponse(
          url,
          headers: headers,
          data: data,
          images: images,
          retryCount: retryCount + 1,
        );
      } else {
        rethrow;
      }
    }
  }

  dynamic _processResponse(http.Response response) {
    debugPrint(response.body);
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.body.isNotEmpty ? jsonDecode(response.body) : {};

      case 204:
        return {"success": true, "message": "Operation successful"};

      case 400:
        throw BadRequestException(response.body);

      case 401:
        throw UnauthorizedException("Unauthorized: ${response.body}");

      case 403:
        _handleForbidden();
        throw UnauthorizedException("Forbidden: ${response.body}");

      case 404:
        throw NotFoundException("Not Found: ${response.body}");

      case 500:
      default:
        throw FetchDataException(
          'Error occurred while communicating with server. '
          'Status code: ${response.statusCode}, Body: ${response.body}',
        );
    }
  }

  Future<void> _handleForbidden() async {
    await _sharedPref.clearAccessToken();
    await _sharedPref.clearRefreshToken();
    await _sharedPref.clearUserdata();
    if (navigatorKey.currentContext != null) {
      Navigator.pushNamedAndRemoveUntil(
        navigatorKey.currentContext!,
        AppRoutes.login,
        (route) => false,
      );
    }
  }
}
