import 'package:http/http.dart' as http;
import 'base_request.dart';
import 'dart:convert';
import 'dart:async';

Future<dynamic> request({BaseRequestModel model}) async {
  final method = model.requestMethod();
  final baseUrl = model.baseUrl();
  final path = model.path();
  final headers = model.requestHeaders();
  final body = model.requestBody();
  if (method == RequestMethod.GET) {
    return getUrl(baseUrl, path, body, headers);
  } else if (method == RequestMethod.POST) {
    return postUrl(baseUrl, path, body, headers);
  } else if (method == RequestMethod.PUT) {
    return putUrl(baseUrl, path, body, headers);
  } else if (method == RequestMethod.DELETE) {
    return deleteUrl(baseUrl, path, body, headers);
  }
}

Future<dynamic> deleteUrl(String baseUrl,String path, Map<String, dynamic> body, Map<String, String> headers) async{
  String url = '$baseUrl$path';
  String paramStr = mapToString(body);
  url += paramStr;

  final response = await http.delete(Uri.parse(url), 
    headers:headers
  );

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load post');
  }
}

Future<dynamic> putUrl(String baseUrl,String path, Map<String, dynamic> body, Map<String, String> headers) async{
  String url = '$baseUrl$path';
  String paramStr = mapToString(body);
  url += paramStr;

  final response = await http.put(Uri.parse(url), 
    headers:headers,
    body: json.encode(body) 
  );

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load post');
  }
}


Future<dynamic> getUrl(String baseUrl,String path, Map<String, dynamic> body, Map<String, String> headers) async {
  String url = '$baseUrl$path';
  String paramStr = mapToString(body);
  url += paramStr;

  final response = await http.get(Uri.parse(url) , headers:headers);
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load post');
  }
}

Future<dynamic> postUrl(String baseUrl, String path, Map<String, dynamic> body, Map<String, String> headers) async {
  String url = '$baseUrl$path';
  final response = await http.post(Uri.parse(url), 
    headers:headers,
    body: json.encode(body)  
  );

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load post');
  }
}

String mapToString(Map<String, dynamic> body) {
  String paramStr = '';
  if (body != null) {
    int index = 0;
    body.forEach((key, val) {
      if (index == 0) {
        paramStr += '?';
      }
      paramStr += '$key=$val';
      if (index != body.length - 1) {
        paramStr += '&';
      }
      index ++;
    });
  }

  return paramStr;
}