import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:post_clean_architecture/core/network/network_into.dart';
import 'package:post_clean_architecture/features/post/data/datasources/post_remote_data_source.dart';
import 'package:post_clean_architecture/features/post/data/repositories/post_repository_impl.dart';
import 'package:post_clean_architecture/features/post/domain/usecases/add_post.dart';
import 'package:post_clean_architecture/features/post/domain/usecases/delete_post.dart';
import 'package:post_clean_architecture/features/post/domain/usecases/get_all_post.dart';
import 'package:post_clean_architecture/features/post/domain/usecases/update_post.dart';
import 'package:post_clean_architecture/features/post/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:post_clean_architecture/features/post/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/post/data/datasources/post_local_data_source.dart';
import 'features/post/domain/repositories/post_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //features post

  //bloc
  sl.registerFactory(() => PostsBloc(getAllPostUseCase: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(
      addPost: sl(), deletePost: sl(), updatePost: sl()));

  //UseCase
  sl.registerLazySingleton(() => GetAllPostUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));

  //repository

  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
      postRemoteDateSource: sl(),
      postLocalDateSource: sl(),
      netWorkInfo: sl()));
//data source

  sl.registerLazySingleton<PostLocalDateSource>(
      () => PostLocalDateSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<PostRemoteDateSource>(
      () => PostRemoteDateSourceImpl(client: sl()));
//core
  sl.registerLazySingleton<NetWorkInfo>(() => NetWorkInfoImpl(sl()));

//External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
