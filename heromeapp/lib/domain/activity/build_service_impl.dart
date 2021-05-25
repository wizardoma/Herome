import 'package:heromeapp/domain/activity/build.dart';
import 'package:heromeapp/domain/activity/build_client.dart';
import 'package:heromeapp/domain/activity/build_service.dart';
import 'package:heromeapp/domain/response.dart';

class BuildServiceImpl extends BuildService {
  final BuildClient buildClient;

  BuildServiceImpl(this.buildClient);

  @override
  Future<ResponseEntity> fetchBuilds(String appId) async {
    print("fetching builds");
    var response = await buildClient.fetchBuilds(appId);
    if (!response.isError) {
      List<Build> builds = [];
      response.data.forEach((e) {
        print("each build: $e");
        if (e["status"] == "succeeded"){
          builds.add(Build(
            id: e["id"],
            date: e["updated_at"],
            isDeploy: true,
            appId: e["app"]["id"],

            status: e["status"],
            userEmail: e["user"]["email"],
            version: e["source_blob"]["version"],
          ));

          builds.add(Build(
            id: e["id"],
            date: e["created_at"],
            isDeploy: false,
            appId: e["app"]["id"],
            status: e["status"],
            userEmail: e["user"]["email"],
            version: e["source_blob"]["version"],
          ),);

        }
        if (e["status"] == "failed"){
          builds.add(Build(
            id: e["id"],
            date: e["created_at"],
            appId: e["app"]["id"],

            isDeploy: false,
            status: e["status"],
            userEmail: e["user"]["email"],
            version: e["source_blob"]["version"],
          ),);
        }
      });
      print("fetched builds: $builds");
      return ResponseEntity(response.isError, builds, null);
    }

    else {
      return response;
    }

  }

}