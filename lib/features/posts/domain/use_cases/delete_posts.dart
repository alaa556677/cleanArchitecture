import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/repo/posts_repo.dart';
import '../../../../core/failure/errors.dart';

class DeletePostUseCases{
  final PostRepoDomain repo;
  DeletePostUseCases(this.repo);
  Future <Either<Failure,Unit>> call(int postId) async{
    return await repo.deletePost(postId);
  }
}