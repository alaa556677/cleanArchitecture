import 'package:bloc/bloc.dart';
import '../../../../../core/failure/errors.dart';
import '../../../domain/use_cases/get_all_posts.dart';
import 'event.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';
import 'state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCases getAllPostsUseCases;
  PostsBloc({required this.getAllPostsUseCases}) : super (PostsInitial()){
    on <PostsEvent> ((event, emit) async {
      if (event is GetAllPostEvent){
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPostsUseCases();
        emit(postState(failureOrPosts));
      }else if (event is RefreshPostEvent){
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPostsUseCases();
        emit(postState(failureOrPosts));
      }
    });
  }

  PostsState postState(Either<Failure, List<PostEntity>> either) {
    return either.fold(
      (failure){
        return ErrorPostsState(message: mapFailureToMessage(failure));
      },
      (posts){
        return SuccessPostsState(posts: posts);
      }
    );
  }

  String mapFailureToMessage(Failure failure){
    switch (failure.runtimeType){
      case ServerFailure:
        return "server failure message";
      case EmptyCashFailure:
        return "Empty cash failure";
      case OfflineFailure:
        return "Offline failure";
      default:
        return 'Unexpected Error';
    }
  }

}
