class Collaborator {
  final String id;
  final String role;
  final String userEmail;
  final List<Map<String, String>> permissions;

  Collaborator({this.id, this.role, this.userEmail, this.permissions});

  factory Collaborator.fromResponse(dynamic data) {
    List<Map<String, String>> permissions = [];
    if (data["permissions"] != null) {
      data["permissions"].forEach((e) {
        permissions.add({"name": e["name"], "description": e["description"]});
      });
    }
      return Collaborator(
          id: data["id"],
          role: data["role"],
          userEmail: data["user"]["email"],
          permissions: permissions);
    }
}
