import 'package:dartz/dartz.dart';
import 'package:post_clean_architecture/features/post/domain/repositories/post_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.dart';

class UpdatePostUseCase{
  final PostRepository repository;

  UpdatePostUseCase(this.repository);
  Future<Either<Failure,Unit>> call(Post post) async{
    return await repository.updatePost(post);
  }

}