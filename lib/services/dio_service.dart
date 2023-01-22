import 'package:dio/dio.dart';
import 'package:insta_post/app/app.logger.dart';
import 'package:insta_post/models/User.dart';

class DioService {
  Dio dio = Dio();
  final logger = getLogger('DioService');
  DioService() {
    dio.options.baseUrl = 'http://192.168.144.50:4000/api/v1/';
  }
  Future<User> getUser(String firebaseUid) async {
    try {
      Map<String, dynamic> response =
          await dio.get('users/$firebaseUid') as Map<String, dynamic>;
      return User.fromMap(response);
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
