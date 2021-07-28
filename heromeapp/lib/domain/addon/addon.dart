import 'package:heromeapp/domain/addon/addon_action.dart';
import 'package:heromeapp/domain/addon/addon_billing.dart';

class Addon {
  final String id;
  final String appId;
  final List<AddonAction> actions;
  final List<String> configVars;
  final String createdAt;
  final String name;
  final String addonServiceName;
  final String planName;
  final String state;
  final String webUrl;
  final AddonBilling billing;

  const Addon(
      {this.id,
      this.appId,
      this.actions,
      this.configVars,
      this.createdAt,
      this.name,
      this.addonServiceName,
      this.planName,
      this.state,
      this.webUrl,
      this.billing});

  factory Addon.fromResponse(dynamic data) {
    List<AddonAction> actions = [];
    AddonBilling billing;
    List<String> configVars = [];
    if (data["config_vars"]!=null){
      data["config_vars"].forEach((e) => configVars.add(e.toString()));
    }

    if (data["actions"] != null) {
      data["actions"].forEach((e) {
        var addonAction = AddonAction.fromData(e);
       actions.add(addonAction);
      });
    }

    if (data["billed_price"]!=null) {
      billing = AddonBilling.fromData(data["billed_price"]);
    }
    var addon = Addon(
        id: data["id"],
        appId: data["app"]["id"],
        configVars: configVars,
        createdAt: data["created_at"],
        name: data["name"],
        addonServiceName: data["addon_service"]["name"],
        planName: data["plan"]["name"],
        state: data["state"],
        webUrl: data["webUrl"],
        billing: billing,
        actions: actions);
    return addon;
  }

}
