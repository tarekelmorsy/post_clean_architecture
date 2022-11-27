import 'package:dartz/dartz.dart';
import 'package:flutter/animation.dart';
import 'package:post_clean_architecture/features/post/domain/entities/post.dart';
import 'package:post_clean_architecture/features/post/domain/repositories/post_repository.dart';

import '../../../../core/error/failure.dart';

class AddPostUseCase{
  final PostRepository repository;
  AddPostUseCase(this.repository);
  Future<Either<Failure,Unit>> call(Post post) async{
    return await repository.addPost(post);
  }
}