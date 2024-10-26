import 'Menu.dart';
import 'Reservation.dart';

enum Status {
  Paid("Paid"),
  Pending("Pending"),
  Unpaid("Unpaid");

  final String _status;
  String get status => _status;
  const Status(this._status);
  @override
  String toString() => status;
}

class Order {
  final int _customerId;
  final int _id;
  final DateTime _date;
  final List<MenuItem> _items = [];
  Status _orderStatus;
  Reservation? reservation;

  int get customerId => _customerId;
  int get id => _id;
  DateTime get date => _date;
  List<MenuItem> get items => _items;
  Status get orderStatus => _orderStatus;

  Order(this._customerId, this._id, this._date,
      [this._orderStatus = Status.Unpaid]);

  void addItem(MenuItem item) {
    _items.add(item);
  }

  void removeItem(MenuItem item) {
    _items.remove(item);
  }

  bool isValid() {
    return _items.isNotEmpty;
  }

  void updateStatus(Status status) => _orderStatus = status;

  double get totalPrice => _items.fold(0, (sum, item) => sum + item.price);

  @override
  String toString() {
    return '===== Order =====\n Order ID: $id\n Customer ID: $customerId\n Date: $date\n===== Ordered Menu =====  ${_items.join(' \n==================')}\n===== Total =====\nPrice: \$${totalPrice.toStringAsFixed(2)}\n===== Status ===== \n$orderStatus\n';
  }
}
