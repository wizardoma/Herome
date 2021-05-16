class Dyno {
  final String id;
  final String state;
  final String type;
  final String updatedAt;

  const Dyno({this.id, this.state, this.type, this.updatedAt});

  factory Dyno.fromResponse(dynamic data){
    return Dyno(
      id: data["id"],
      state: data["state"],
      type: data["type"],
      updatedAt: data["updated_at"]
    );
  }

  @override
  String toString() {
    return 'Dyno{id: $id, state: $state, type: $type, updatedAt: $updatedAt}';
  }
}