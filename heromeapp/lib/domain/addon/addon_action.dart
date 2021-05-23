class AddonAction {
  final String id;
  final String label;
  final String action;
  final String url;
  final bool requiresOwner;

  const AddonAction({this.id, this.label, this.action, this.url, this.requiresOwner});

  factory AddonAction.fromData(dynamic data) {
    return AddonAction(
      id: data["id"],
      label: data["label"],
      action: data["action"],
      url: data["url"],
      requiresOwner: data["requires_owner"],
    );
  }



}