class Customer {
  final int _customerId;
  final String _name;
  final String _phone;

  int get customerId => _customerId;
  String get name => _name;
  String get phone => _phone;

  Customer(this._customerId, this._name, this._phone);

  @override
  String toString() {
    return 'Customer(id: $customerId, name: $name, contactInfo: $phone)';
  }
}
