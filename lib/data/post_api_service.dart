import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:flutterchopper/data/built_value_convertor.dart';
import 'package:flutterchopper/model/built_post.dart';

part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: 'https://jsonplaceholder.typicode.com/posts')
abstract class PostApiService extends ChopperService {
  @Get()
  Future<Response<BuiltList<BuiltPost>>> getPosts();

  @Get(path: '{id}')
  Future<Response<BuiltPost>> getPost(@Path('id') int id);

  @Post()
  Future<Response<BuiltPost>> postPost(
    @Body() BuiltPost body,
  );

  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [
        _$PostApiService(),
      ],
      converter: BuiltValueConvertor(),
      interceptors: [
        HeadersInterceptor({'Cache-Control': 'no-cache'}),
      ],
    );
    return _$PostApiService(client);
  }
}
