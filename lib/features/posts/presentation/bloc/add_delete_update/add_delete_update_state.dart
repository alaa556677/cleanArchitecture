part of 'add_delete_update_bloc.dart';

@immutable
abstract class AddDeleteUpdateState extends Equatable{
  const AddDeleteUpdateState();
  @override
  List <Object> get props => [];
}

class AddDeleteUpdateInitial extends AddDeleteUpdateState {}

class AddDeleteUpdatePostsLoading extends AddDeleteUpdateState{}

class AddDeleteUpdatePostsSuccess extends AddDeleteUpdateState{
  final String message;
  const AddDeleteUpdatePostsSuccess({required this.message});
  @override
  List <Object> get props => [message];
}

class AddDeleteUpdatePostsError extends AddDeleteUpdateState{
  final String message;
  const AddDeleteUpdatePostsError({required this.message});
  @override
  List <Object> get props => [message];
}


