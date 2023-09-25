import 'package:dio/dio.dart';

import 'package:yawar_task/data/models/item_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../core/error/exceptios.dart';
import '../../core/network/error_message_model.dart';
import '../../core/utils/app_constances/api_constance.dart';

abstract class BasePostsRemoteDataSource {
  Future<List<ItemModel>> getPosts({int page});
  Future<void> createPost(String content, List<Map<String, dynamic>> mediaList);
}

class PostsRemoteDataSource extends BasePostsRemoteDataSource {
  @override
  Future<List<ItemModel>> getPosts({int page = 1}) async {
    final response = await Dio().get('${ApiConstance.getPostsUrl} + $page',
        options: Options(
          validateStatus: (_) => true,
          headers: {
            'Accept': 'application/json',
            'Authorization': 'bearer ${ApiConstance.token}',
          },
        ));
    if (response.statusCode == 200) {
      return List<ItemModel>.from((response.data['data']['items'] as List)
          .map((e) => ItemModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.formJson(response.data));
    }
  }

  @override
  Future<void> createPost(
      String content, List<Map<String, dynamic>> mediaList) async {
    final storage = FirebaseStorage.instance;
    List<Map<String, dynamic>> mediaData = [];
    for (Map<String, dynamic> media in mediaList) {
      final storageReference =
          storage.ref().child('media/${media['filename']}');

      UploadTask uploadTask = storageReference.putFile(media['file']);

      String downloadUrl = '';
      await uploadTask.whenComplete(() async {
        downloadUrl = await storageReference.getDownloadURL();
      });
      mediaData.add({
        'src_url': downloadUrl,
        'src_thum': downloadUrl,
        'src_icon': downloadUrl,
        'media_type': media['media_type'],
        'mime_type': media['mime_type'],
        'fullPath': media['fullPath'],
        "width": media['width'],
        "height": media['height'],
        'size': media['size'],
      });
    }

    final data = {
      'content': content,
      'media': mediaData,
      'friends_ids': [],
    };

    final response = await Dio().post(ApiConstance.createPostUrl,
        data: data,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'bearer ${ApiConstance.token}',
          },
          validateStatus: (_) => true,
        ));
    if (response.statusCode == 201) {
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.formJson(response.data));
    }
  }
}
