import 'dart:convert';

class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

dynamic validateResponse(response) {
  switch (response.statusCode) {
    case 200:
      return json.decode(response.body);
    case 400:
      throw Failure(response.body.toString());
    case 401:
    case 403:
      throw Failure(response.body.toString());
    case 500:
    default:
      throw Failure(
          'Error occured while Communication with Server with StatusCode : ${response
              .statusCode}');
  }
}