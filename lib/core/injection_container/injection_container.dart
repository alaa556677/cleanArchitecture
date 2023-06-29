import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app/features/posts/domain/use_cases/add_posts.dart';
import 'package:posts_app/features/posts/domain/use_cases/delete_posts.dart';
import 'package:posts_app/features/posts/domain/use_cases/get_all_posts.dart';
import 'package:posts_app/features/posts/domain/use_cases/update_posts.dart';
import 'package:posts_app/features/posts/presentation/bloc/add_delete_update/add_delete_update_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/posts/data/database/post_local_data_source.dart';
import '../../features/posts/data/database/post_remote_data_source.dart';
import '../../features/posts/data/repo/repo_implement.dart';
import '../../features/posts/domain/repo/posts_repo.dart';
import '../network_check/network_check.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

Future <void> init() async {
  ///////// feature posts

  // bloc
  locator.registerFactory(() => PostsBloc(getAllPostsUseCases: locator()));
  locator.registerFactory(() => AddDeleteUpdateBloc(addPostUseCases: locator(), updatePostUseCases: locator(), deletePostUseCases: locator()));

  // use cases
  // lazy singleTone: don't create the object unless we need it
  // single: when the program open the object will create
  locator.registerLazySingleton(() => GetAllPostsUseCases(locator()));
  locator.registerLazySingleton(() => AddPostUseCases(locator()));
  locator.registerLazySingleton(() => UpdatePostUseCases(locator()));
  locator.registerLazySingleton(() => DeletePostUseCases(locator()));

  // repository
  locator.registerLazySingleton <PostRepoDomain> (() => PostsRepoImplement(
    localDataSource: locator(),
    networkCheck: locator(),
    remoteDataSource: locator()
  ));

  // data sources
  locator.registerLazySingleton <PostLocalDataSource> (() => PostLocalDataSourceImplement(sharedPreferences: locator()));
  locator.registerLazySingleton <PostRemoteDataSource> (() => PostRemoteDataSourceImplement(client: locator()));

  /////////// core
  locator.registerLazySingleton <NetworkCheck> (() => NetworkCheckImplementation(connectionChecker: locator()));

  ////////// external
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => InternetConnectionChecker());
}