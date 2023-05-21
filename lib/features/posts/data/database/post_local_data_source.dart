import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/core/failure/exception.dart';
import 'package:posts_app/features/posts/data/model/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource{
  Future <List<PostModel>> getCashedPosts();
  Future <Unit> cashPosts(List<PostModel> postModel);
}

const cashedPosts = 'CASHED_POSTS';

class PostLocalDataSourceImplement implements PostLocalDataSource{
  SharedPreferences? sharedPreferences;
  PostLocalDataSourceImplement({this.sharedPreferences});
  @override
  Future<Unit> cashPosts(List<PostModel> postModel) {
    List postModelsToJson = postModel.map <Map <String, dynamic>> ((postModel) => postModel.toJson()).toList();
    sharedPreferences?.setString(cashedPosts, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCashedPosts() {
    final jsonString = sharedPreferences?.getString(cashedPosts);
    if(jsonString != null){
      List decodeJsonData = json.decode(jsonString);
      List <PostModel> jsonToPostModel = decodeJsonData.map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel)).toList();
      return Future.value(jsonToPostModel);
    }else{
      throw EmptyCashException();
    }
  }
}