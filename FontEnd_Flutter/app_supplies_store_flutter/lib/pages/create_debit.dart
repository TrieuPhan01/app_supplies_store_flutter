import 'dart:convert';

import 'package:app_supplies_store_flutter/fields/indent_dield.dart';
import 'package:app_supplies_store_flutter/providers/employees_provider.dart';
import 'package:app_supplies_store_flutter/providers/user_povider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateDebitWidget extends StatefulWidget {
  const CreateDebitWidget({super.key});
  @override
  State<CreateDebitWidget> createState() => _CreateDebitWidgetState();
}

class _CreateDebitWidgetState extends State<CreateDebitWidget> {
  final _nameController = TextEditingController();
  final _noteController = TextEditingController();
  final _totalMoneyController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _phoneError;
  String? UserIDDebit;
  bool _autoValidate = false;
  final String apiUrl = dotenv.env['API_URL'] ?? 'No API URL Found';

  Future<bool> checkPhoneNumber(String phoneNumber) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final phoneNumberes = await http.get(
      Uri.parse('$apiUrl/api/User/NamebyCustomerId/$phoneNumber'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer ${user?.token}',
      },
    );
    // print("check phone number ${phoneNumberes.body}");
    // print("check namer ${_nameController.text}");
    // print("check note ${_noteController.text}");
    // print("check total ${_totalMoneyController.text}");

    if (phoneNumberes.statusCode == 200) {
      final dataa = jsonDecode(phoneNumberes.body);
      print('dataaaaaaaaaaaaaaaaaaaaa ${dataa}');
       UserIDDebit = dataa;
      return true;
    } 
     else if (phoneNumberes.statusCode == 204) {
      UserIDDebit = 'b4e5feb2-92e5-4e69-a7ee-0467ba4452bc';
      return true;
    } 
    else if (phoneNumberes.statusCode == 400) {
      return false;
    } else {
      throw Exception('Failed to check phone number');
    }
  }

  Future<void> _submitForm() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final employeesProvider = Provider.of<EmployeesProvider>(context, listen: false);
    final employee = employeesProvider.employees;
    if (_formKey.currentState!.validate()) {
      setState(() {
        _autoValidate = true;
      });
      try {
        // print("vào respo");
        // print("vào _nameController.text ${_nameController.text}");
        // print("vào _noteController.text ${_noteController.text}");
        // print("vào _totalMoneyController.text ${_totalMoneyController.text}");
        // print("vào UserIDDebit $UserIDDebit");
        // print("vào user?.id ${employee?.employeeId}");
        
        String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now().toUtc());
        print(formattedDate);

        final response = await http.post(
          Uri.parse('$apiUrl/api/Debits/Create'),
          headers: <String, String>{
            'Content-Type':
                'application/json',
                'Authorization': 'Bearer ${user?.token}',
          },
          body: jsonEncode({
            "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            "name": (_nameController.text).toString(),
            "note": (_noteController.text).toString(),
            "totalMoney": int.parse(_totalMoneyController.text),
            "paymentStatus": false,
            // "debPurchaseDate": DateTime.now().toUtc().toIso8601String(),
            "debPurchaseDate": "2024-10-17T10:57:38.450Z",
            "customerID": UserIDDebit,
            "employeeID": employee?.employeeId,
            "storeID": "b8450678-42c5-49f2-a0e0-6ca9f859387b"
          }),
        );
        print(UserIDDebit);
        print(response.body);
        if (response.statusCode == 201) {
          print("vào 200");
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tạo ghi nợ thành công!')));
          print("navigate");
          Navigator.pushReplacementNamed(context, '/debitManage');
        
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Vui lòng thử lại sau 1 vài phút')),
          );
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Có lỗi xảy ra. Vui lòng thử lại sau.')),
        );
      }
    }
  }

  void validatePhoneNumber() async {
    String value = _phoneNumberController.text;

    if (value != '' && !RegExp(r'^\d{10}$').hasMatch(value)) {
      setState(() {
        _phoneError = 'Vui lòng nhập số điện thoại hợp lệ (10 chữ số)';
      });
    } else if (value.isNotEmpty) {
      try {
        bool isValid = await checkPhoneNumber(value);
        print(isValid);
        setState(() {
          if (!isValid) {
            _phoneError = 'Số điện thoại không tồn tại';
          } else {
            _phoneError = null;
          }
        });
      } catch (e) {
        setState(() {
          _phoneError =
              'Không thể kiểm tra số điện thoại. Vui lòng thử lại sau.';
        });
      }
    } else {
      setState(() {
        _phoneError = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Thêm ghi nợ',
            style: TextStyle(
              fontFamily: 'SourceSans',
              fontSize: 35,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: IndentField(
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autoValidate
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 1, 20),
                        child: Text(
                            "Vui lòng nhập đầy đủ thông tin ghi nợ của khách hàng"),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nhập tên khách hàng',
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Trường này không được để trống';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: TextFormField(
                          controller: _noteController,
                          decoration: const InputDecoration(
                            labelText: 'Thông tin sản phẩm',
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Trường này không được để trống';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: TextFormField(
                          controller: _totalMoneyController,
                          decoration: const InputDecoration(
                            labelText: 'Nhập tổng số tiền ghi nợ',
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Trường này không được để trống';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: TextFormField(
                          controller: _phoneNumberController,
                          decoration: InputDecoration(
                            labelText: 'Nhập SĐT Khách hàng (Nếu có)',
                            border: UnderlineInputBorder(),
                            errorText: _phoneError,
                          ),
                          onEditingComplete: () {
                            validatePhoneNumber();
                            FocusScope.of(context).unfocus();
                          },
                          onChanged: (value) async {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              UserIDDebit =
                                  'b4e5feb2-92e5-4e69-a7ee-0467ba4452bc';
                            }

                            if (_phoneError != null) {
                              return _phoneError;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 70, 161, 236),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 15),
                        ),
                        child: const Text(
                          'Thêm ghi nợ',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            letterSpacing: 0.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
