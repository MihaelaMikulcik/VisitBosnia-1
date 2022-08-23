import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

import '../utils/util.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  static String? baseUrl;
  String? _endpoint;

  HttpClient client = new HttpClient();
  IOClient? http;

  BaseProvider(String endpoint) {
    baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://10.0.2.2:44346/");

    if (baseUrl!.endsWith("/") == false) {
      baseUrl = baseUrl! + "/";
    }

    _endpoint = endpoint;
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  Future<T> getById(int id, [dynamic additionalData]) async {
    var url = Uri.parse("$baseUrl$_endpoint/$id");

    Map<String, String> headers = createHeaders();

    var response = await http!.get(url, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data) as T;
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  Future<List<T>> get([dynamic search]) async {
    var url = "$baseUrl$_endpoint";

    if (search != null) {
      String queryString = getQueryString(search);
      url = url + "?" + queryString;
    }

    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();
    // print("get me");
    // Map<String, String> headers = {
    //   HttpHeaders.contentTypeHeader: "application/json",
    //   "Connection": "Keep-Alive",
    //   "Keep-Alive": "timeout=5, max=1000"
    // };

    var response = await http!.get(uri, headers: headers);
    // print("done $response");
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return data.map((x) => fromJson(x)).cast<T>().toList();
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  Future<T?> insert(dynamic request) async {
    var url = "$baseUrl$_endpoint";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();
    var jsonRequest = jsonEncode(request);
    var response = await http!.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data) as T;
    } else {
      return null;
    }
  }

  Future<T?> update(int id, [dynamic request]) async {
    var url = "$baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();

    var response =
        await http!.put(uri, headers: headers, body: jsonEncode(request));

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data) as T;
    } else {
      return null;
    }
  }

  Future<T?> delete(int id) async {
    var url = "$baseUrl$_endpoint/delete/$id";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();

    var response = await http!.delete(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data) as T;
    } else {
      return null;
    }
  }

  Map<String, String> createHeaders() {
    String? username = Authorization.username;
    String? password = Authorization.password;

    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$username:$password'))}";

    var headers = {
      "Content-Type": "application/json",
      "Authorization": basicAuth
    };
    return headers;
  }

  T fromJson(data) {
    throw Exception("Override method");
  }

  String getQueryString(Map params,
      {String prefix: '&', bool inRecursion: false}) {
    String query = '';
    params.forEach((key, value) {
      if (inRecursion) {
        if (key is int) {
          key = '[$key]';
        } else if (value is List || value is Map) {
          key = '.$key';
        } else {
          key = '.$key';
        }
      }
      if (value is String || value is int || value is double || value is bool) {
        var encoded = value;
        if (value is String) {
          encoded = Uri.encodeComponent(value);
        }
        // query == "" ? query+='$key=$encoded' : query += '$prefix$key=$encoded';
        query += '$prefix$key=$encoded';
      } else if (value is DateTime) {
        query += '$prefix$key=${(value as DateTime).toIso8601String()}';
      } else if (value is List || value is Map) {
        if (value is List) value = value.asMap();
        value.forEach((k, v) {
          query +=
              getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
        });
      }
    });
    return query;
  }

  // String getQueryString(Map params,
  //     {String prefix: '&', bool inRecursion: false}) {
  //   String query = '';
  //   params.forEach((key, value) {
  //     if (inRecursion) {
  //       if (key is int) {
  //         key = '[$key]';
  //       } else if (value is List || value is Map) {
  //         key = '.$key';
  //       } else {
  //         key = '.$key';
  //       }
  //     }
  //     if (value is String || value is int || value is double || value is bool) {
  //       var encoded = value;
  //       if (value is String) {
  //         encoded = Uri.encodeComponent(value);
  //       }
  //       query += '$prefix$key=$encoded';
  //     } else if (value is DateTime) {
  //       query += '$prefix$key=${(value as DateTime).toIso8601String()}';
  //     } else if (value is List || value is Map) {
  //       if (value is List) value = value.asMap();
  //       value.forEach((k, v) {
  //         query +=
  //             getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
  //       });
  //     }
  //   });
  //   return query;
  // }

  bool isValidResponseCode(Response response) {
    if (response.statusCode == 200) {
      if (response.body != "") {
        return true;
      } else {
        return false;
      }
    } else if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 400) {
      throw Exception("Bad request");
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else if (response.statusCode == 403) {
      throw Exception("Forbidden");
    } else if (response.statusCode == 404) {
      throw Exception("Not found");
    } else if (response.statusCode == 500) {
      throw Exception("Internal server error");
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }
}
