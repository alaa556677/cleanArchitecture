part of 'add_delete_update_bloc.dart';

@immutable
abstract class AddDeleteUpdateEvent extends Equatable{
  const AddDeleteUpdateEvent();
  @override
  List <Object> get props => [];
}

class AddPostsEvent extends AddDeleteUpdateEvent{
  final PostEntity post;
  const AddPostsEvent({required this.post});
  @override
  List <Object> get props => [post];
}

class DeletePostsEvent extends AddDeleteUpdateEvent{
  final int postId;
  const DeletePostsEvent({required this.postId});
  @override
  List <Object> get props => [postId];
}

class UpdatePostsEvent extends AddDeleteUpdateEvent{
  final PostEntity post;
  const UpdatePostsEvent({required this.post});
  @override
  List <Object> get props => [post];
}
