import 'package:dartz/dartz.dart';
import 'package:post_clean_architecture/core/error/failure.dart';
import 'package:post_clean_architecture/features/post/domain/repositories/post_repository.dart';

class DeletePostUseCase{
  final PostRepository repository;

  DeletePostUseCase(this.repository);
  Future<Either<Failure,Unit>> call(int id) async{
    return await repository.deletePost(id);
  }
}