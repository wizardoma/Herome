import 'package:dio/dio.dart';
import 'package:heromeapp/domain/api/heroku_api.dart';
import 'package:heromeapp/domain/auth/auth_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

Dio dio = Dio(BaseOptions(
  baseUrl: BaseUrl,
))
  ..interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) => requestInterceptors(options, handler),
  ));

requestInterceptors(RequestOptions options, RequestInterceptorHandler handler) async {
  options.headers
      .putIfAbsent("Accept", () => "application/vnd.heroku+json; version=3");

  var pref = await SharedPreferences.getInstance();
  var token = pref.getString(AuthStore.prefName);
  options.headers.putIfAbsent("Authorization", () => "Basic $token");
  handler.next(options);
}
