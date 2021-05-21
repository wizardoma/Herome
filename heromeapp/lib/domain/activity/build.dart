class Build {
  final String id;
  final String date;
  final bool isDeploy;
  final String status;
  final String userEmail;
  final String version;

  Build({this.id, this.date, this.isDeploy, this.status, this.userEmail, this.version});

  @override
  String toString() {
    return 'Build{id: $id, date: $date, isDeploy: $isDeploy, status: $status, userEmail: $userEmail, version: $version}';
  }
}