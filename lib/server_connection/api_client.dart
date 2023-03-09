import 'package:dio/dio.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/sign_in/model/sign_in_request.dart';
import 'package:g_worker_app/sign_in/model/sign_in_response.dart';

class ApiClient {
  Dio dio = Dio();

  Future<SignInResponse> login(SignInRequest request) async {
    try {
      var response = await dio.post('${API.baseUrl}${ApiEndPoints.login}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));
      return SignInResponse.fromJson(response.data);
    } on DioError {
      rethrow;
    } catch (e) {
      print('ApiClient.adminLogin Error :: \ne');
      rethrow;
    }
  }
}
