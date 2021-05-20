import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'app.g.dart';

@HiveType(typeId: 0)
class App {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String webUrl;
  @HiveField(3)
  final String language;

  const App({
    @required this.id,
    @required this.name,
    @required this.webUrl,
    this.language = "",
  });

  factory App.fromResponse(dynamic data) {
    return App(
      id: data["id"],
      name: data["name"],
      webUrl: data["web_url"],
      language: data["buildpack_provided_description"],
    );
  }

  @override
  String toString() {
    return 'App{id: $id, name: $name, webUrl: $webUrl, language: $language}';
  }
}
