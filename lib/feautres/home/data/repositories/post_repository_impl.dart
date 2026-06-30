import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_remote_datasource.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<PostEntity>> getPosts() async {
    final models = await remoteDataSource.fetchPosts();
    return models
        .map(
          (m) => PostEntity(
            userId: m.userId,
            id: m.id,
            title: m.title,
            body: m.body,
          ),
        )
        .toList();
  }
}
