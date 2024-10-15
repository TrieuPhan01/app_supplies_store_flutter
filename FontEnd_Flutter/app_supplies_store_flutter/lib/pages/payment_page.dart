import 'dart:convert';
import 'package:app_supplies_store_flutter/fields/indent_dield.dart';
import 'package:app_supplies_store_flutter/providers/customer_povider.dart';
import 'package:app_supplies_store_flutter/providers/user_povider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  double totalAmount = 0.0;
  var OrderId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateTotalAmount();
    });
  }

  String formatCurrency(double amount) {
    final formatCurrency =
        NumberFormat.currency(locale: 'vi_VN', symbol: '₫', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  Future<void> _fetProduct() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final cus = customerProvider.customer;
    final String apiUrl = dotenv.env['API_URL'] ?? 'No API URL Found';
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final detailProduct = args['product'];
    final _count = args['count'];
    var uuid = Uuid();
    OrderId = uuid.v4();

    try {
      final bodyData = {
        "order": "someOrderValue",
        "id": OrderId,
        "shipAddress": "${_addressController.text}",
        "shippperDate": "2024-10-13T15:27:57.585Z",
        "totalAmount": totalAmount,
        "orderStatus": false,
        "paymentType": "Online",
        "storeID": "b8450678-42c5-49f2-a0e0-6ca9f859387b",
        "employeeID": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "customerID": "${cus?.id}",
        "orderDetails": [
          {
            "id": uuid.v4(),
            "unitPrice": "VND",
            "quantity": "${_count}",
            "discount": "No discount",
            "subTotal": totalAmount,
            "productID": "${detailProduct.ProductID}"
          }
        ]
      };

      print('$apiUrl/api/Orders/Create');
      print(bodyData);
      final productResponse = await http.post(
        Uri.parse('$apiUrl/api/Orders/Create'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user?.token}',
        },
        body: jsonEncode(bodyData),
      );
      if (productResponse.statusCode == 201) {
        print("Thành công");
      } else {
        throw Exception('Không thể lấy dữ liệu');
      }
    } catch (e) {
      print(e);
      // throw Exception('Lỗi! Vui lòng thử lại sau ít phút');
    }
  }

  void _calculateTotalAmount() {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final detailProduct = args['product'];
    final _count = args['count'];
    setState(() {
      totalAmount = (detailProduct.price as num).toDouble() * _count.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final customer = customerProvider.customer;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final detailProduct = args['product'];
    final _count = args['count'];
    _firstnameController = TextEditingController(text: '${user?.lastName}');
    _phoneNumberController =
        TextEditingController(text: '${user?.phoneNumber}');
    _addressController = TextEditingController(text: '${customer?.address}');
    return GestureDetector(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'THANH TOÁN HÓA ĐƠN',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 24,
                letterSpacing: 0.0,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: IndentField(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Đơn hàng của bạn',
                    style: TextStyle(
                      fontFamily: 'SourceSans',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 25),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 224, 233, 247),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 4, 0, 2),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 1, 10, 1),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        '${detailProduct.picture}',
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 15, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${detailProduct.productName}',
                                            style: const TextStyle(
                                              fontFamily: 'SourceSans',
                                              fontSize: 28,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 10, 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 8, 5),
                                    child: Text(
                                      'Số lượng: $_count',
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontFamily: 'SourceSans',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                    size: 35,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Giá tiền:  ',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'MontserratSemiBold',
                                      color: Colors.black,
                                    ),
                                  ),
                                  Wrap(
                                    alignment: WrapAlignment.end,
                                    children: [
                                      Text(
                                        formatCurrency(
                                            detailProduct.price!.toDouble() *
                                                _count),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'MontserratSemiBold',
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 14, 0, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Tổng số tiền',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'MontserratSemiBold',
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          formatCurrency(totalAmount),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MontserratSemiBold',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color(0xFF407F3E),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
                    child: Column(
                      children: [
                        const Text(
                          'Thông tin đặt hàng',
                          style: TextStyle(
                            fontFamily: 'SourceSans',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: TextFormField(
                            controller: _firstnameController,
                            decoration: const InputDecoration(
                              labelText: 'Tên khách hàng',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Không được để trống!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: TextFormField(
                            controller: _phoneNumberController,
                            decoration: const InputDecoration(
                              labelText: 'Số điện thoại',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Không được để trống!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: TextFormField(
                            controller: _addressController,
                            decoration: const InputDecoration(
                              labelText: 'Địa chỉ giao hàng',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Không được để trống!';
                              }
                              return null;
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                          child: Text(
                            'Chọn phương thức thanh toán',
                            style: TextStyle(
                              fontFamily: 'SourceSans',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  _fetProduct();
                                  Map<String, dynamic> _jsonDataMomo = {
                                    'OrderId': OrderId,
                                    'totalAmount':
                                        totalAmount.toStringAsFixed(0),
                                  };
                                  Navigator.pushNamed(context, '/getmomo',
                                      arguments: jsonEncode(_jsonDataMomo));
                                },
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.4,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image.asset(
                                        'assets/images/logomomo.png',
                                      ).image,
                                    ),
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .end, // Đặt nội dung ở dưới cùng
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          'Momo',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'MontserratSemiBold',
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  // Xử lý sự kiện khi nhấn nút thứ hai
                                  print('Nút thứ hai được nhấn');
                                },
                                child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.4,
                                    height: 160,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 217, 231, 243),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.payments,
                                            color: Colors.black,
                                            size: 44,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 12, 0, 12),
                                            child: Text(
                                              'Thanh toán Khi nhận hàng',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    'MontserratSemiBold',
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
