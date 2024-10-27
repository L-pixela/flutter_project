enum Category {
  Drink("Drink"),
  Food("Food"),
  Dessert("Dessert");

  final String _type;
  String get type => _type;
  const Category(this._type);
  @override
  String toString() => type;
}

class MenuItem {
  final int _id;
  final String _name;
  final Category _category;
  final double _price;

  String get name => _name;
  Category get category => _category;
  double get price => _price;
  int get id => _id;

  MenuItem(this._id, this._name, this._category, this._price);

  @override
  String toString() {
    return '\nItem ID: $id, Name: $name, Category: $category, Price: \$$price';
  }
}

class Menu {
  final List<MenuItem> _items = [
    MenuItem(1, "Burger", Category.Food, 5),
    MenuItem(2, "Coca", Category.Drink, 0.75),
    MenuItem(3, "Pizza", Category.Food, 15),
    MenuItem(4, "Ice-Cream", Category.Dessert, 1),
    MenuItem(5, "Fried Rice", Category.Food, 2),
    MenuItem(6, "Noodle", Category.Food, 2),
    MenuItem(7, "Cookie", Category.Dessert, 0.25),
  ];

  MenuItem? getItemById(int id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  void displayMenu() {
    print("Menu");
    for (var item in _items) {
      print(item);
    }
  }
}
