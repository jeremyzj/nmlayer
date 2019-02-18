
enum RequestMethod {
  GET,
  POST,
  PUT,
  DELETE
}

enum RequestDataType {
  JSON
}

enum ResponseDataType {
  JSON
}

abstract class BaseRequestModel {
  //请求方式
  RequestMethod requestMethod() {
    return RequestMethod.GET;
  }

  String baseUrl() {
    return '';
  }

  String path() {
    return '';
  }

  //headers
  Map<String, String> requestHeaders() {
    return {'Content-Type':'application/json'};
  }

  //request body
  Map<String, dynamic> requestBody() {
    return {};
  }

  //request data type
  RequestDataType requestDataType() {
    return RequestDataType.JSON;
  }

  //respone data type
  ResponseDataType responseDataType() {
    return ResponseDataType.JSON;
  }
}