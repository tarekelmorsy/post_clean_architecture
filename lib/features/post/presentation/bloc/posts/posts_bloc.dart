import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:post_clean_architecture/core/error/failure.dart';

import '../../../../../core/strings/failure.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/get_all_post.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostUseCase getAllPostUseCase;

  PostsBloc({required this.getAllPostUseCase}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GatAllPostsEvent) {
        emit(LoadingPostState());
        final failureOrPosts = await getAllPostUseCase();
        emit(_mapFailureOrPostState(failureOrPosts));
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostState());
        final failureOrPosts = await getAllPostUseCase();
        emit(_mapFailureOrPostState(failureOrPosts));
      }
    });
  }

  PostsState _mapFailureOrPostState(Either<Failure,List<Post>> either){
   return either.fold(
            (failure) => ErrorPostState(message: _mapFailureToMessage(failure)),
            (posts) => LoadedPostsState(posts: posts));
  }
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
