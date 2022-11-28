part of 'posts_bloc.dart';

@immutable
abstract class PostsState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class PostsInitial extends PostsState {}

class LoadedPostsState extends PostsState{
  final List<Post> posts;

  LoadedPostsState({required this.posts});
  @override
  // TODO: implement props
  List<Object?> get props => [posts];
}
class LoadingPostState extends PostsState{
}
class ErrorPostState extends PostsState{
  final String message;

  ErrorPostState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}