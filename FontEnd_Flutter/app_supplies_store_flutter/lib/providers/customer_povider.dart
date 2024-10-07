import 'package:flutter/material.dart';

class Customer {
  String? id;
  int? age;
  int? sex;
  String? address;

  Customer({
    required this.id,
    this.age,
    this.sex,
    this.address,
  });

  Customer.zero()
      : id = "rỗng",
        age = 0,
        sex = 0,
        address = "rỗng";
}

class CustomerProvider with ChangeNotifier {
  Customer? _customer;

  Customer? get customer => _customer;

  void setCustomer(Customer? customer) {
    print(
        "cus trong provided ${customer?.address} ${customer?.age} ${customer?.id} ${customer?.sex}");
    _customer = customer;
    print(customer?.address);
    notifyListeners();
  }
}
