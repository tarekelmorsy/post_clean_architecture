
import 'package:dartz/dartz.dart';
import 'package:post_clean_architecture/features/post/domain/entities/post.dart';

import '../../../../core/error/failure.dart';

abstract class PostRepository{
  Future<Either<Failure,List<Post>>> getAllPosts();
  Future<Either<Failure,Unit>> deletePost(int id);
  Future<Either<Failure,Unit>>updatePost(Post post);
  Future<Either<Failure,Unit>>addPost(Post post);



}