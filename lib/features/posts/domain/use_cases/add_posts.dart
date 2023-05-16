import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'package:posts_app/features/posts/domain/repo/posts_repo.dart';
import '../../../../core/failure/errors.dart';

class AddPostUseCases{
  final PostRepoDomain repo;
  AddPostUseCases(this.repo);
  Future <Either<Failure,Unit>> call(PostEntity post) async{
    return await repo.addPost(post);
  }
}
