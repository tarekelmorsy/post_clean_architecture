import 'package:flutter/material.dart';
import 'package:post_clean_architecture/core/app_theme.dart';
import 'package:post_clean_architecture/features/post/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:post_clean_architecture/features/post/presentation/bloc/posts/posts_bloc.dart';
import 'features/post/presentation/pages/posts_page.dart';
import 'injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      MultiBlocProvider(providers: [
        BlocProvider(create:(_)=> di.sl<PostsBloc>()..add(GatAllPostsEvent())),
        BlocProvider(create:(_)=> di.sl<AddDeleteUpdatePostBloc>()),
      ], child:  MaterialApp(
        title: 'posts app',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: PostsPage()  ,
      ))

     ;
  }
}
