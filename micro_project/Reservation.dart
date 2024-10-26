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
    return '===== Reservation =====\n Rerservation ID: $id\n Customer ID: $customerId\n Table Number: $tableNumber\n Time: $time\n People: $numberOfPeople';
  }
}
