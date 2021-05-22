class Dyno {
  final String id;
  final String appId;
  final String state;
  final String name;
  final String type;
  final String updatedAt;

  const Dyno({this.id, this.appId, this.state, this.name, this.type, this.updatedAt});

  factory Dyno.fromResponse(dynamic data) {
    return Dyno(
      id: data["id"],
      name: data["name"],
      appId: data["app"]["id"],
      state: data["state"],
      type: data["type"],
      updatedAt: data["updated_at"],
    );
  }

  @override
  String toString() {
    return 'Dyno{id: $id, state: $state, name: $name, type: $type, updatedAt: $updatedAt}';
  }
}
