

class DebitProvider {
  final String id;
  String? name;
  String? note;
  int? totalMoney;
  bool? paymentStatus;
  String? debPurchaseDate;
  String? customerID;
  String? employeeID;
  String? storeID;

  DebitProvider({
    required this.id,
    this.name,
    this.note,
    this.totalMoney,
    this.paymentStatus,
    this.debPurchaseDate,
    this.customerID,
    this.employeeID,
    this.storeID,
  });
}
