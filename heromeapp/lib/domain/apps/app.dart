import 'package:flutter/foundation.dart';

class App {
  final String id;
  final String name;
  final String webUrl;
  final String language;

  const App({
    @required this.id,
    @required this.name,
    @required this.webUrl,
    this.language = "",
  });

  factory App.fromResponse(dynamic data){
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