import 'Order.dart';

class Reservation {
  final int id;
  final int customerId;
  final int tableNumber;
  final DateTime time;
  final int numberOfPeople;
  Order? order; // Optional association with an order

  Reservation(this.id, this.customerId, this.tableNumber, this.time,
      this.numberOfPeople);

  @override
  String toString() {
    return 'Reservation(id: $id, customerId: $customerId, tableNumber: $tableNumber, time: $time, numberOfPeople: $numberOfPeople)';
  }
}
