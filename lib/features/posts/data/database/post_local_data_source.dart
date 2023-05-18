import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/data/model/post_model.dart';

abstract class PostLocalDataSource{
  Future <List<PostModel>> getCashedPosts();
  Future <Unit> cashPosts(List<PostModel> postModel);
}

class PostLocalDataSourceImplement implements PostLocalDataSource{
  @override
  Future<Unit> cashPosts(List<PostModel> postModel) {
    // TODO: implement cashPosts
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getCashedPosts() {
    // TODO: implement getCashedPosts
    throw UnimplementedError();
  }
}