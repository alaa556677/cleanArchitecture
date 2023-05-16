import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/repo/posts_repo.dart';
import '../../../../core/failure/errors.dart';
import '../entities/post.dart';

class GetAllPostsUseCases{
  final PostRepoDomain repo;
  GetAllPostsUseCases(this.repo);
  Future <Either<Failure , List <PostEntity>>> call() async{
    return await repo.getAllPosts();
  }
}

