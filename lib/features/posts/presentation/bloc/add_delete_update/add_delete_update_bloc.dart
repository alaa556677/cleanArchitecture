import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';

import '../../../../../core/failure/errors.dart';
import '../../../domain/use_cases/add_posts.dart';
import '../../../domain/use_cases/delete_posts.dart';
import '../../../domain/use_cases/update_posts.dart';
part 'add_delete_update_event.dart';
part 'add_delete_update_state.dart';

class AddDeleteUpdateBloc extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {
  final AddPostUseCases addPostUseCases;
  final UpdatePostUseCases updatePostUseCases;
  final DeletePostUseCases deletePostUseCases;

  AddDeleteUpdateBloc(
  {required this.addPostUseCases,
    required this.updatePostUseCases,
    required this.deletePostUseCases}
 ) : super(AddDeleteUpdateInitial()) {
    on<AddDeleteUpdateEvent>((event, emit) async {
      if(event is AddPostsEvent){
        emit(AddDeleteUpdatePostsLoading());
        final failureOrDoneMessage = await addPostUseCases(event.post);
        emit(addDeleteUpdateState(failureOrDoneMessage, 'Post is adding successfully'));
      }else if (event is DeletePostsEvent){
        emit(AddDeleteUpdatePostsLoading());
        final failureOrDone = await deletePostUseCases(event.postId);
        emit(addDeleteUpdateState(failureOrDone, 'Post is deleting successfully'));
      }else if(event is UpdatePostsEvent){
        emit(AddDeleteUpdatePostsLoading());
        final failureOrDone = await updatePostUseCases(event.post);
        addDeleteUpdateState(failureOrDone, 'Post is updating successfully');
      }
    });
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

  AddDeleteUpdateState addDeleteUpdateState(Either<Failure, Unit> either, String message) {
    return either.fold(
            (failure){
          return AddDeleteUpdatePostsError(message: mapFailureToMessage(failure));
        },
            (_){
          return AddDeleteUpdatePostsSuccess(message: message);
        }
    );
  }
}
