import 'package:equatable/equatable.dart';
import 'package:posts_app/features/posts/domain/entities/post.dart';

abstract class PostsState extends Equatable{
  const PostsState();
  @override
  List <Object> get props => [];
}

class PostsInitial extends PostsState{}

class LoadingPostsState extends PostsState{}

class SuccessPostsState extends PostsState{
  final List posts;
  const SuccessPostsState({required this.posts});
  @override
  List <Object> get props => [posts];
}

class ErrorPostsState extends PostsState{
  final String message;
  const ErrorPostsState({required this.message});
  @override
  List <Object> get props => [message];
}