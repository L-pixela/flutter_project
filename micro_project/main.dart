import 'Customer.dart';
import 'Menu.dart';
import 'Order.dart';
import 'Reservation.dart';
import 'dart:io';

void main() {
  // Step 1: Create a customer
  Customer customer = Customer(1, "John Doe", "123-456-7890");

  // Step 2: Create a reservation
  Reservation reservation =
      Reservation(1, customer.customerId, 5, DateTime.now(), 4);

  // Step 3: Create an order
  Order order = Order(customer.customerId, 1, DateTime.now(), Status.Pending);
  Menu menu = Menu();

  // Display the menu
  menu.displayMenu();

  // Take user input for ordering
  while (true) {
    print("Enter the ID of the item you want to order (or 'done' to finish):");
    String? input = stdin.readLineSync();

    if (input == null || input.toLowerCase() == 'done') {
      break;
    }

    int? itemId = int.tryParse(input);
    if (itemId != null) {
      MenuItem? item = menu.getItemById(itemId);
      if (item != null) {
        order.addItem(item);
        print("${item.name} added to your order.");
      } else {
        print("Item with ID $itemId not found.");
      }
    } else {
      print("Invalid input. Please enter a valid item ID.");
    }
  }

  // Link the order to the reservation
  reservation.order = order;
  order.reservation = reservation;

  if (order.orderStatus == Status.Pending) {
    print("Do you want to Pay?(yes/no)");
    String? input = stdin.readLineSync();
    if (input == "no") {
      order.updateStatus(Status.Unpaid);
    } else if (input == "yes") {
      order.updateStatus(Status.Paid);
    } else {
      order.updateStatus(Status.Pending);
    }
  }

  // Print details
  print("\nCustomer Details:");
  print(customer);
  print("\nReservation Details:");
  print(reservation);
  print("\nOrder Details:");
  print(order);
}


// void main() {
//   // Step 1: Create a customer
//   Customer customer = Customer(1, "John Doe", "123-456-7890");

//   // Step 2: Create a reservation
//   Reservation reservation =
//       Reservation(1, customer.customerId, 5, DateTime.now(), 4);

//   // Step 3: Create an order and link it to the reservation
//   Order order = Order(customer.customerId, 1, DateTime.now(), Status.Pending);
//   Menu menu = Menu();
//   MenuItem? item1 = menu.getItemById(1);
//   MenuItem? item2 = menu.getItemById(2);

//   if (item1 != null) order.addItem(item1);
//   if (item2 != null) order.addItem(item2);

//   reservation.order = order;
//   order.reservation = reservation;

//   // Step 4: Update order status to Paid when completed
//   order.updateStatus(Status.Paid);

//   // Print details
//   print(customer);
//   print(reservation);
//   print(order);
// }