import 'Customer.dart';
import 'Menu.dart';
import 'Order.dart';
import 'Reservation.dart';

void main() {
  // Step 1: Create a customer
  Customer customer = Customer(1, "John Doe", "123-456-7890");

  // Step 2: Create a reservation
  Reservation reservation =
      Reservation(1, customer.customerId, 5, DateTime.now(), 4);

  // Step 3: Create an order and link it to the reservation
  Order order = Order(customer, 1, DateTime.now(), Status.Pending);
  Menu menu = Menu();
  MenuItem? item1 = menu.getItemById(1);
  MenuItem? item2 = menu.getItemById(2);

  if (item1 != null) order.addItem(item1);
  if (item2 != null) order.addItem(item2);

  reservation.order = order;
  order.reservation = reservation;

  // Step 4: Update order status to Paid when completed
  order.updateStatus(Status.Paid);

  // Print details
  print(customer);
  print(reservation);
  print(order);
}
