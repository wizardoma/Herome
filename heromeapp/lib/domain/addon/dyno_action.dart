class DynoAction {
  final String id;
  final String label;
  final String action;
  final String url;
  final bool requiresOwner;

  DynoAction({this.id, this.label, this.action, this.url, this.requiresOwner});

  factory DynoAction.fromData(dynamic data) {
    return DynoAction(
      id: data["id"],
      label: data["label"],
      action: data["action"],
      url: data["url"],
      requiresOwner: data["requires_owner"],
    );
  }



}