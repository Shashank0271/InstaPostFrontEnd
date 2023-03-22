import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_post/app/app.logger.dart';
import 'package:insta_post/models/User.dart';

import '../models/Post.dart';

class DioService {
  Dio dio = Dio();
  final logger = getLogger('DioService');
  DioService() {
    dio.options.baseUrl = 'http://10.20.25.222:4000/api/v1/';
  }

  Future<void> createUser({required user}) async {
    try {
      logger.d("entered create user method");
      var formData = FormData.fromMap(user.toMap());
      logger.i("Sending request");
      Response response = await dio.post('users', data: formData);
      logger.d(response.data);
    } on DioError catch (e) {
      logger.e(e.response);
      logger.e(e.message);
      rethrow;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  Future<UserModel> getUser({required String firebaseUid}) async {
    try {
      final Response response = await dio.get('users/$firebaseUid');
      Map<String, dynamic> responseJson =
          Map<String, dynamic>.from(response.data);
      return UserModel.fromMap(responseJson);
    } on DioError catch (e) {
      logger.e(e.message);
      logger.e(e.response!.statusCode);
      rethrow;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  Future<Post?> createPost(
      {required XFile postImage,
      required String title,
      required String body,
      required String category,
      required String userFirebaseId,
      required String userName}) async {
    final testPost = FormData.fromMap({
      "title": title,
      "body": body,
      "userFirebaseId": userFirebaseId,
      "userName": userName,
      "category": category,
      "photo": await MultipartFile.fromFile(postImage.path),
    });
    try {
      final response = await dio.post('posts', data: testPost);
      Map<String, dynamic> responseJson =
          Map<String, dynamic>.from(response.data);
      return Post.fromMap(responseJson);
    } on DioError catch (e) {
      logger.e(e.response);
      logger.e(e.message);
      rethrow;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  Future<Post?> getPost(String postid) async {
    try {
      logger.v('fetching post with postID = $postid');
      final Response response = await dio.get('posts/fetchpost/$postid');
      final requiredPost = Post.fromMap(response.data);
      logger.d(requiredPost);
      return requiredPost;
    } on DioError catch (e) {
      logger.e(e.message);
      logger.e(e.response);
      rethrow;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  Future<List<Post>> getAllPosts() async {
    try {
      final Response response = await dio.get('posts');
      logger.v("fetched all posts : ${response.data}");
      List<Post> allPosts =
          (response.data as List).map((e) => Post.fromMap(e)).toList();
      return allPosts;
    } on DioError catch (e) {
      logger.e(e.response);
      logger.e(e.message);
      rethrow;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  Future<void> follow(
      {required String currentUserFid, required String postUserFid}) async {}
  Future<void> getCurrentUsersPosts() async {}
}
