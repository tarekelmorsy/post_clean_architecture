import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:post_clean_architecture/core/error/exception.dart';
import 'package:post_clean_architecture/features/post/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
const CACHED_POST="CACHED_POST";
 abstract class  PostLocalDateSource{
  Future<List<PostModel>> getCachedPosts();
  Future<Unit>cachePosts(List<PostModel> postModels);
}
class PostLocalDateSourceImpl implements PostLocalDateSource{
   final SharedPreferences sharedPreferences;

  PostLocalDateSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
   List posModelsToJson=postModels.map<Map<String,dynamic>>((postModels)=>postModels.toJson()).toList();

   sharedPreferences.setString(CACHED_POST, json.encode(posModelsToJson));
   return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString=sharedPreferences.getString(CACHED_POST);
    if(jsonString!=null){
      List decodeJsonData=json.decode(jsonString);
      List<PostModel> jsonToPostModel=decodeJsonData.map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel)).toList();
      return Future.value(jsonToPostModel);
    }else{
      throw EmptyCacheException();
    }
  }
   
}