import 'package:dio/dio.dart';
import 'package:insta_post/app/app.logger.dart';
import 'package:insta_post/models/User.dart';

class DioService {
  Dio dio = Dio();
  final logger = getLogger('DioService');
  DioService() {
    dio.options.baseUrl = 'http://10.20.23.215:4000/api/v1/';
  }

  Future<void> createUser({required user}) async {
    try {
      var formData = FormData.fromMap(user.toMap());
      logger.i("Sending request");
      Response response = await dio.post('users', data: formData);
      logger.d(response.data);
    } on DioError catch (e) {
      logger.e(e.response);
      logger.e(e.message);
      rethrow;
    }
  }

  Future<UserModel> getUser({required String firebaseUid}) async {
    try {
      Map<String, dynamic> response =
          await dio.get('users/$firebaseUid') as Map<String, dynamic>;
      return UserModel.fromMap(response);
    } on DioError catch (e) {
      logger.e(e.message);
      logger.e(e.response!.statusCode);
      rethrow;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }
}
