
import 'package:dartz/dartz.dart';
import 'package:post_clean_architecture/features/post/domain/repositories/post_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.dart';

class GetAllPostUseCase {
  final PostRepository repository;

  GetAllPostUseCase(this.repository);

  Future<Either<Failure,List<Post>>> call() async{
    return await repository.getAllPosts();
  }

}