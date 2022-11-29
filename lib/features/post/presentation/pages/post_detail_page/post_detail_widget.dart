import '../../widgets/delete_post_btn_widget.dart';
import '../../widgets/update_post_btn_widget.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/post.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;

  const PostDetailWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("post detail"),
      ),
      body:
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                post.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                height: 50,
              ),
              Text(
                post.body,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Divider(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  UpdatePostBtnWidget(post: post),
                  DeletePostBtnWidget(postId: post.id!)
                ],
              )
            ],
          ),
        ),

    );
  }
}
