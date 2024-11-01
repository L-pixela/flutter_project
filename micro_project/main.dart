// ignore_for_file: unnecessary_null_comparison

import 'Customer.dart';
import 'Menu.dart';
import 'Order.dart';
import 'Reservation.dart';
import 'dart:io';

//Check for reservation ID in List
Reservation? findReservationById(
    List<Reservation> reservations, int reservationId) {
  try {
    return reservations.firstWhere((res) => res.id == reservationId,
        orElse: () => throw Exception('Reservation not found'));
  } catch (e) {
    print("An error occurred while searching for the reservation: $e");
    return null;
  }
}

//Check for Customer ID in List
Customer? findCustomerById(List<Customer> customers, int customerId) {
  try {
    return customers.firstWhere((cust) => cust.customerId == customerId,
        orElse: () => throw Exception('Customer not found'));
  } catch (e) {
    print("An error occurred while searching for the customer: $e");
    return null;
  }
}

// Check if the Customer Exist in List Already
bool isCustomerExists(List<Customer> customers, int customerId) {
  return customers.any((customer) => customer.customerId == customerId);
}

// Check if the Reservation Exist in List Already
bool isReservationUnique(List<Reservation> reservations, int reservationId) {
  return !reservations.any((reservation) => reservation.id == reservationId);
}

int getInputAsInt(String message) {
  print(message);
  return int.parse(stdin.readLineSync()!);
}

String getInputAsString(String message) {
  print(message);
  return stdin.readLineSync()!;
}

// Add Customer Function
void addCustomer(List<Customer> customers) {
  print("===== Customer Input =====");
  int customerId = getInputAsInt("Enter customer ID:");
  if (isCustomerExists(customers, customerId)) {
    print("Customer ID already exist!. Choose a unique one.");
    return;
  }
  String name = getInputAsString("Enter customer name:");
  String phone = getInputAsString("Enter customer phone:");
  customers.add(Customer(customerId, name, phone));
  print("Customer added successfully.");
}

// Add Reservation Function
void addReservation(List<Customer> customers, List<Reservation> reservations) {
  print("===== Reservation Input =====");
  int reservationId = getInputAsInt("Enter reservation ID:");
  if (!isReservationUnique(reservations, reservationId)) {
    print("Reservation ID already exist! Choose a Unique one.");
    return;
  }

  int customerId = getInputAsInt("Enter customer ID:");
  if (!isCustomerExists(customers, customerId)) {
    print("Customer don't exist! Choose an existing one");
    return;
  }
  int tableNumber = getInputAsInt("Enter table number:");
  int numberOfPeople = getInputAsInt("Enter number of people:");
  reservations.add(Reservation(
      reservationId, customerId, tableNumber, DateTime.now(), numberOfPeople));
  print("Reservation made successfully.");
}

// Place Order Function
void placeOrder(List<Customer> customers, List<Reservation> reservations,
    List<Order> orders, Menu menu) {
  int reservationId = getInputAsInt("Enter reservation ID:");
  Reservation? reservation = findReservationById(reservations, reservationId);

  if (reservation != null) {
    Customer? customer = findCustomerById(customers, reservation.customerId);
    if (customer != null) {
      Order order = Order(
          customer.customerId, reservationId, DateTime.now(), Status.Pending);
      menu.displayMenu();

      while (true) {
        String? input = getInputAsString(
            "Enter the ID of the item you want to order (or 'done' to finish):");

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

      reservation.order = order;
      order.reservation = reservation;
      if (order.orderStatus == Status.Pending) {
        String? input = getInputAsString("Do you want to Pay?(yes/no):");
        if (input == "no") {
          order.updateStatus(Status.Unpaid);
        } else if (input == "yes") {
          order.updateStatus(Status.Paid);
        } else {
          order.updateStatus(Status.Pending);
        }
      }

      orders.add(order);

      print("\nOrder placed successfully.\n");

      print(customer);
      print(reservation);
      print(order);
    } else {
      print("Customer not found.");
    }
  } else {
    print("Reservation not found.");
  }
}

void main() {
  List<Customer> customers = [];
  List<Reservation> reservations = [];
  List<Order> orders = [];
  Menu menu = Menu();

  while (true) {
    print("===== Restaurant Management System =====");
    print("1. Input Customer");
    print("2. Input Reservation");
    print("3. Customer Place Order");
    print("4. Exit");
    print("Choose your choice.");

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        addCustomer(customers);
        break;

      case '2':
        addReservation(customers, reservations);
        break;

      case '3':
        placeOrder(customers, reservations, orders, menu);
        break;

      case '4':
        return;

      default:
        print("Invalid choice. Please try again.");
        break;
    }
  }
}

// void main() {
//   // Create a customer
//   Customer customer = Customer(1, "John Doe", "123-456-7890");

//   // Create a reservation
//   Reservation reservation =
//       Reservation(1, customer.customerId, 5, DateTime.now(), 4);

//   // Create an order and link it to the reservation
//   Order order = Order(customer.customerId, 1, DateTime.now(), Status.Pending);
//   Menu menu = Menu();
//   MenuItem? item1 = menu.getItemById(1);
//   MenuItem? item2 = menu.getItemById(2);

//   if (item1 != null) order.addItem(item1);
//   if (item2 != null) order.addItem(item2);

//   reservation.order = order;
//   order.reservation = reservation;

//   // Update order status to Paid when completed
//   order.updateStatus(Status.Paid);

//   // Print details
//   print(customer);
//   print(reservation);
//   print(order);
// }