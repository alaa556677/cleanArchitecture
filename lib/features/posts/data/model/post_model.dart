import 'package:posts_app/features/posts/domain/entities/post.dart';

class PostModel extends PostEntity{
  PostModel({required int id, required String body, required String title})
  : super(id: id, title: title,body: body);

}