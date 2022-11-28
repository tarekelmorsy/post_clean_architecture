import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_clean_architecture/features/post/presentation/bloc/posts/posts_bloc.dart';
import 'package:post_clean_architecture/features/post/presentation/pages/post_add_update_page.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../widgets/PostListWidget.dart';
import '../widgets/message_display_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("post"),
      ),floatingActionButton: _buildFloatingBtn(context),
      body: _buildBody() ,


    );
  }
  Widget _buildBody(){
    return Padding(padding:const EdgeInsets.all(10),
    child: BlocBuilder<PostsBloc,PostsState>(builder: (context,state){
      if(state is LoadingPostState)
        return LoadingWidget();
      else if(state is LoadedPostsState){
        return RefreshIndicator(
          onRefresh:()=> _onRefresh(context),
            child: PostListWidget(posts:state.posts));
      }else if(state is ErrorPostState) {
        return MessageDisplayWidget(message: state.message);
      }
      return LoadingWidget();

    },));
  }
  Widget _buildFloatingBtn(BuildContext context){
    return FloatingActionButton(onPressed: (){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => PostAddUpdatePage(
                isUpdatePost: false,
              )));

    },child: Icon(Icons.add),);
  }

 Future<void> _onRefresh(BuildContext context) async {

    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }
}
