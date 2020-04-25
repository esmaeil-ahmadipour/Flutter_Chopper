import 'package:chopper/chopper.dart';
import 'package:flutterchopper/data/mobile_data_interceptor.dart';

part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: 'https://jsonplaceholder.typicode.com/posts')
abstract class PostApiService extends ChopperService {
  @Get()
  Future<Response> getPosts();

  @Get(path: '{id}')
  Future<Response> getPost(@Path('id') int id);

  @Post()
  Future<Response> postPost(
    @Body() Map<String, dynamic> body,
  );

  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [
        _$PostApiService(),
      ],
      converter: JsonConverter(),
      interceptors: [
        HeadersInterceptor({'Cache-Control': 'no-cache'}),
        CurlInterceptor(),
        (Request request) async {
          if (request.method == HttpMethod.Post) {
            chopperLogger.info('>>> Post <<<');
          }
          return request;
        },
        MobileDataInterceptor(),
      ],
    );
    return _$PostApiService(client);
  }
}
