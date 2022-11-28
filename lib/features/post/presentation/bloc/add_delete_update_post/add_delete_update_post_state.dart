part of 'add_delete_update_post_bloc.dart';

@immutable
abstract class AddDeleteUpdatePostState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AddDeleteUpdatePostInitial extends AddDeleteUpdatePostState {}
class LoadingAddDeleteUpdatePostState extends AddDeleteUpdatePostState{

}
class ErrorAddDeleteUpdatePostState extends AddDeleteUpdatePostState {
final String message;

  ErrorAddDeleteUpdatePostState({required this.message});
@override
// TODO: implement props
List<Object?> get props => [message];
}
class MessageAddDeleteUpdatePostState extends AddDeleteUpdatePostState{
  final String message;

  MessageAddDeleteUpdatePostState({required this.message});
  @override
// TODO: implement props
  List<Object?> get props => [message];
}