import 'Customer.dart';
import 'Menu.dart';

enum Status { Paid, Pending, Unpaid }

class Order {
  final Customer _customerId;
  final int _id;
  final DateTime _date;
  final List<MenuItem> _items = [];
  Status _orderStatus;

  Customer get customerId => _customerId;
  int get id => _id;
  DateTime get date => _date;
  List<MenuItem> get items => _items;
  Status get orderStatus => _orderStatus;

  Order(this._customerId, this._id, this._date, this._orderStatus);

  void addItem(MenuItem item) {
    _items.add(item);
  }

  void removeItem(MenuItem item) {
    _items.remove(item);
  }

  void set updateStatus(Status status) => _orderStatus = status;

  double get totalPrice => _items.fold(0, (sum, item) => sum + item.price);
}
