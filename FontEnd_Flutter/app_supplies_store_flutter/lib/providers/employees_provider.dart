import 'package:flutter/material.dart';

class Employees {
  String? employeeId;
  String? hireDate; // Ngày thê/ký kết hợp đồng
  int? salary; // Tiền lương
  String? position; // Chức vụ

  Employees({
    required this.employeeId,
    this.hireDate,
    this.salary,
    this.position,
  });

  Employees.zero()
      : employeeId = "rỗng",
        hireDate = "rỗng",
        salary = 0,
        position = "rỗng";
}

class EmployeesProvider with ChangeNotifier {
  Employees? _employees;

  Employees? get employees => _employees;

  void setEmployees(Employees? employees) {
    _employees = employees;
    notifyListeners();
  }
}
