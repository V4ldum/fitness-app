import 'api_code.dart';

class APIResponse<T> {
  final APICode statusCode;
  final T? content;

  APIResponse(this.statusCode, this.content);

  bool isStatus(APICode code) {
    return code == statusCode;
  }
}
