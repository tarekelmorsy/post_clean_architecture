import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:post_clean_architecture/core/error/exception.dart';
import 'package:post_clean_architecture/features/post/data/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDateSource {
  Future<List<PostModel>> getPosts();

  Future<Unit> deletePost(int id);

  Future<Unit> updatePost(PostModel postModel);

  Future<Unit> addPost(PostModel postModel);
}

const BASE_URL = "https://jsonplaceholder.typicode.com";

class PostRemoteDateSourceImpl implements PostRemoteDateSource {
  final http.Client client;

  PostRemoteDateSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getPosts() async {
    final respons = await client.get(
      Uri.parse(BASE_URL + "/posts/"),
      headers: {"Content-Type": "application/json"},
    );
    if (respons.statusCode == 200) {
      final decodedJson = json.decode(respons.body) as List;
      final List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel)async {
   final body={"title":postModel.title,
   "body":postModel.body};
   final response=await client.post(Uri.parse(BASE_URL+"/posts/"),body: body);
   if(response.statusCode==201){
     return Future.value(unit);
   }else{
     throw ServerException();
   }

  }

  @override
  Future<Unit> deletePost(int id)async {
    final respons = await client.delete(
      Uri.parse(BASE_URL + "/posts/${id.toString()}"),
      headers: {"Content-Type": "application/json"},
    );
    if (respons.statusCode == 200) {
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async{
    final postId=postModel.id.toString();
    final body ={"title": postModel.title,"body":postModel.body};
    final response=await client.patch(Uri.parse(BASE_URL+"/posts/$postId"),body: body);
    if(response.statusCode==200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }

  }
}
