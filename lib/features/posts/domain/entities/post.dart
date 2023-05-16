import 'package:equatable/equatable.dart';

class PostEntity extends Equatable{
  final int id;
  final String title;
  final String body;
  const PostEntity({required this.id, required this.body, required this.title});

  @override
  List<Object?> get props => [id, title, body];

}