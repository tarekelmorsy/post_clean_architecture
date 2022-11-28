import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/post.dart';
import '../pages/post_detail_page/post_detail_widget.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostListWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder: (context,index){
      return ListTile(leading: Text(posts[index].id.toString()),
      title:  Text(posts[index].title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        subtitle: Text(
          posts[index].body,
          style: TextStyle(fontSize: 16),
        ),  contentPadding: EdgeInsets.symmetric(horizontal: 10),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PostDetailWidget(post: posts[index]),
            ),
          );
        },
      );
    },
      separatorBuilder: (context, index) => Divider(thickness: 1), itemCount: posts.length,
    );
  }
}

