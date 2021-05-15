class Account {
  final String id;
  final String email;
  final String name;
  final String smsNumber;
  final bool verified;

  const Account({
    this.id,
    this.email,
    this.name,
    this.smsNumber = "",
    this.verified,
  });

  factory Account.fromResponse(dynamic data) {
    return Account(
        id: data["id"],
        email: data["email"],
        name: data["name"],
        smsNumber: data["sms_number"],
        verified: data["verified"]);
  }

  @override
  String toString() {
    return 'Account{id: $id, email: $email, name: $name, smsNumber: $smsNumber, verified: $verified}';
  }
}
