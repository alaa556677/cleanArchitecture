import 'package:dartz/dartz.dart';
import 'package:posts_app/core/failure/errors.dart';
import 'package:posts_app/core/failure/exception.dart';
import 'package:posts_app/features/posts/data/database/post_local_data_source.dart';
import 'package:posts_app/features/posts/data/database/post_remote_data_source.dart';
import 'package:posts_app/features/posts/data/model/post_model.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import '../../../../core/network_check/network_check.dart';
import '../../domain/repo/posts_repo.dart';

typedef DeleteUpdateAdd = Future<Unit> Function();
class PostsRepoImplement implements PostRepoDomain {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkCheck networkCheck;

  PostsRepoImplement(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkCheck});

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    if (await networkCheck.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cashPosts(remotePosts);
        return right(remotePosts);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCashedPosts();
        return right(localPosts);
      } on EmptyCashException {
        return left(EmptyCashFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostEntity post) async {
    PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await getMessage((){
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await getMessage((){
      return remoteDataSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntity post) async {
    PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await getMessage((){
      return remoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> getMessage(DeleteUpdateAdd deleteUpdateAdd) async {
    if (await networkCheck.isConnected) {
      try {
        await deleteUpdateAdd();
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
