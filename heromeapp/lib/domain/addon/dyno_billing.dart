class DynoBilling {
  final int cents;
  final bool contract;
  final String unit;

  DynoBilling({this.cents, this.contract, this.unit});

  factory DynoBilling.fromData(dynamic data){
    return DynoBilling(
      cents: data["cents"],
      contract: data["cents"],
      unit: data["unit"],
    );
  }
}