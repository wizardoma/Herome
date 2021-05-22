import 'package:heromeapp/domain/addon/dyno_action.dart';
import 'package:heromeapp/domain/addon/dyno_billing.dart';

class Addon {
  final String id;
  final String appId;
  final List<DynoAction> actions;
  final List<String> configVars;
  final String createdAt;
  final String name;
  final String addonServiceName;
  final String planName;
  final String state;
  final String webUrl;
  final DynoBilling billing;

  Addon({this.id, this.appId, this.actions, this.configVars, this.createdAt, this.name, this.addonServiceName, this.planName, this.state, this.webUrl, this.billing});

  factory Addon.fromResponse(dynamic data) {
    List<DynoAction> actions;
    DynoBilling billing;

    if (data["actions"]!=null){
      actions = _getActions(data["actions"]);
    }

    if (data["billed_price"]){
      billing = DynoBilling.fromData(data["billed_price"]);
    }
    return Addon(
      id: data["id"],
      appId: data["app"]["id"],
      configVars: data["config_vars"].map((e) => e.toString()).toList(),
      createdAt: data["created_at"],
      name: data["name"],
      addonServiceName: data["addon_service"]["name"],
      planName: data["plan"]["name"],
      state: data["state"],
      webUrl: data["webUrl"],
      billing: billing,
      actions: actions
    );
  }

  static List<DynoAction> _getActions(data) {
    return data.map((e) {
      return DynoAction.fromData(e);
    }).toList();
  }


}