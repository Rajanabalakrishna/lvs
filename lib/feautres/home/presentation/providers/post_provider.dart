import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../data/datasources/post_remote_datasource.dart';
import '../../data/repositories/post_repository_impl.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/usecases/get_posts_usecase.dart';

final httpClientProvider = Provider<http.Client>((_) => http.Client());

final postRemoteDataSourceProvider = Provider<PostRemoteDataSource>(
  (ref) => PostRemoteDataSourceImpl(client: ref.watch(httpClientProvider)),
);

final postRepositoryProvider = Provider(
  (ref) => PostRepositoryImpl(
    remoteDataSource: ref.watch(postRemoteDataSourceProvider),
  ),
);

final getPostsUseCaseProvider = Provider(
  (ref) => GetPostsUseCase(ref.watch(postRepositoryProvider)),
);

final postsProvider = FutureProvider<List<PostEntity>>(
  (ref) => ref.watch(getPostsUseCaseProvider).call(),
);
