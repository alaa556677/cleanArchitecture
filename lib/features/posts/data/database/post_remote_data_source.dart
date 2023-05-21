import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/data/model/post_model.dart';
import 'package:http/http.dart' as http;
import '../../../../core/failure/exception.dart';

abstract class PostRemoteDataSource{
  Future <List<PostModel>> getAllPosts();
  Future <Unit> deletePost(int postId);
  Future <Unit> updatePost(PostModel postModel);
  Future <Unit> addPost(PostModel postModel);
}

class PostRemoteDataSourceImplement implements PostRemoteDataSource{
  final http.Client client;
  PostRemoteDataSourceImplement({required this.client});

  String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse(baseUrl),
    headers: {
      "Content-Type" : "application/json"
    });
    if(response.statusCode == 200){
      final List decodedJson = json.decode(response.body) as List;
      final List <PostModel> postsModel = decodedJson.map <PostModel> ((jsonPostModel) => PostModel.fromJson(jsonPostModel)).toList();
      return postsModel;
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      "title" : postModel.title,
      "body" : postModel.body,
    };
    final response = await client.post(Uri.parse(baseUrl), body: body);
    if(response.statusCode == 201){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(Uri.parse("$baseUrl${postId.toString()}"), headers: {
      "Content-Type" : "application/json"
    });
    if(response.statusCode == 200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final body = {
      "title" : postModel.title,
      "body" : postModel.body,
    };
    final response = await client.patch(Uri.parse("$baseUrl$postId"), body: body);
    if(response.statusCode == 200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }
  
}