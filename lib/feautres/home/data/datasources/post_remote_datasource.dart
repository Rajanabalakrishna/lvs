import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> fetchPosts();
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> fetchPosts() async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;
      return jsonList
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load posts: ${response.statusCode}');
    }
  }
}
