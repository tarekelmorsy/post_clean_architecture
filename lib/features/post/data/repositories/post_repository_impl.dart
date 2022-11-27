import 'package:dartz/dartz.dart';
import 'package:post_clean_architecture/core/error/exception.dart';
import 'package:post_clean_architecture/core/error/failure.dart';
import 'package:post_clean_architecture/features/post/data/models/post_model.dart';
import 'package:post_clean_architecture/features/post/domain/entities/post.dart';
import 'package:post_clean_architecture/features/post/domain/repositories/post_repository.dart';

import '../../../../core/network/network_into.dart';
import '../datasources/post_local_data_source.dart';
import '../datasources/post_remote_data_source.dart';

typedef Future<Unit> DeleteOrUpdateOrAddPost();

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDateSource postRemoteDateSource;
  final PostLocalDateSource postLocalDateSource;
  final NetWorkInfo netWorkInfo;

  PostRepositoryImpl(
      {required this.postRemoteDateSource,
      required this.postLocalDateSource,
      required this.netWorkInfo});

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() {
      return postRemoteDateSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await _getMessage(() {
      return postRemoteDateSource.deletePost(id);
    });
  }

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await netWorkInfo.isConnected) {
      try {
        final remotePosts = await postRemoteDateSource.getPosts();
        postLocalDateSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    try {
      final localPosts = await postLocalDateSource.getCachedPosts();
      return Right(localPosts);
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() {
      return postRemoteDateSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost function) async {
    if (await netWorkInfo.isConnected) {
      try {
        await function;
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
