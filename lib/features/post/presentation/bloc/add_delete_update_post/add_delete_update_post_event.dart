part of 'add_delete_update_post_bloc.dart';

@immutable
abstract class AddDeleteUpdatePostEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddPostEvent extends AddDeleteUpdatePostEvent{
  final Post post;

  AddPostEvent({required this.post});
  @override
  // TODO: implement props
  List<Object?> get props => [post];
}
class UpdatePostEvent extends AddDeleteUpdatePostEvent{
  final Post post;

  UpdatePostEvent({required this.post});
  @override
  // TODO: implement props
  List<Object?> get props => [post];
}
class DeletePostEvent extends AddDeleteUpdatePostEvent{
  final int postId;

  DeletePostEvent({required this.postId});
  @override
  // TODO: implement props
  List<Object?> get props => [postId];
}