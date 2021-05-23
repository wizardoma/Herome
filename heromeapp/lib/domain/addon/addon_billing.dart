class AddonBilling {
  final int cents;
  final bool contract;
  final String unit;

  const AddonBilling({this.cents, this.contract, this.unit});

  factory AddonBilling.fromData(dynamic data){
    return AddonBilling(
      cents: data["cents"],
      contract: data["contract"],
      unit: data["unit"],
    );
  }
}