import 'dart:convert';

import 'package:app_supplies_store_flutter/fields/indent_dield.dart';
import 'package:app_supplies_store_flutter/providers/customer_povider.dart';
import 'package:app_supplies_store_flutter/providers/user_povider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    final String apiUrl = dotenv.env['API_URL'] ?? 'No API URL Found';
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    final cus = customerProvider.customer;


    if (cus == null) {
      final response = await http.get(
        Uri.parse('$apiUrl/api/Customers/GetByUserID/${user?.id}'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer ${user?.token}',
        },
      );

      Customer cus = Customer.zero();
      if (response.statusCode == 200) {
        final customerData = jsonDecode(response.body) as Map<String, dynamic>;
        cus = Customer(
          id: customerData['custommerId'] as String,
          age: customerData['age'] as int,
          sex: customerData['sex'] as int,
          address: customerData['address'] as String,
        );
      }
      final cusProvider = Provider.of<CustomerProvider>(context, listen: false);
      cusProvider.setCustomer(cus);
    }
  }

  @override
  Widget build(BuildContext context) {
    _fetchUserProfile();
    return (GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xfff1f4f8),
        appBar: AppBar(
          backgroundColor: const Color(0xfff1f4f8),
          automaticallyImplyLeading: false,
          title: const Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
              child: Text(
                'Thông tin cá nhân',
                style: TextStyle(
                  fontFamily: 'SourceSans',
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              )),
        ),
        body: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Column(
            children: [
              IndentField(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Consumer<UserProvider>(
                          builder: (context, userProvider, child) {
                            return Text(
                              ' ${userProvider.user!.firstName ?? ' '} ${userProvider.user!.lastName ?? userProvider.user!.userName ?? 'bạn'} ',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontFamily: 'SourceSans',
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Consumer<UserProvider>(
                          builder: (context, userProvider, child) {
                            return Text(
                              ' ${userProvider.user!.roles ?? ' '} ',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 151, 133, 127),
                                fontSize: 18,
                                fontFamily: 'SourceSans',
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IndentField(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                        child: Consumer<UserProvider>(
                          builder: (context, userProvider, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email: ${userProvider.user!.email ?? ' '}',
                                  style: const TextStyle(
                                    color: Color(0xff12103D),
                                    fontSize: 18,
                                    fontFamily: 'MontserratSemiBold',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    'Số điện thoại: ${userProvider.user!.phoneNumber ?? ' '}',
                                    style: const TextStyle(
                                      color: Color(0xff12103D),
                                      fontSize: 18,
                                      fontFamily: 'MontserratSemiBold',
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                        child: Consumer<CustomerProvider>(
                          builder: (context, customerProvider, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tuổi: ${customerProvider.customer?.age ?? ' '}',
                                  style: const TextStyle(
                                    color: Color(0xff12103D),
                                    fontSize: 18,
                                    fontFamily: 'MontserratSemiBold',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    'Giới tính: ${customerProvider.customer?.sex ?? ' '}',
                                    style: const TextStyle(
                                      color: Color(0xff12103D),
                                      fontSize: 18,
                                      fontFamily: 'MontserratSemiBold',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    'Địa chỉ: ${customerProvider.customer?.address ?? ' '}',
                                    style: const TextStyle(
                                      color: Color(0xff12103D),
                                      fontSize: 18,
                                      fontFamily: 'MontserratSemiBold',
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 50, 0, 0),
                        child: ElevatedButton.icon(
                          icon: const Icon(
                            Icons.supervised_user_circle_outlined,
                            color: Colors.black,
                            size: 24,
                          ),
                          onPressed: () {},
                          label: const Text(
                            'Sửa thông tin người dùng',
                            style: TextStyle(
                              fontFamily: 'SourceSans',
                              letterSpacing: 0.0,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 243, 244, 245),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            minimumSize:
                                const Size(390, 50), // Đặt kích thước cố định
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            10, 10, 0, 0), // Padding cho nút đăng xuất
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          label: const Text(
                            'Đăng xuất',
                            style: TextStyle(
                              fontFamily: 'SourceSans',
                              letterSpacing: 0.0,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 243, 244, 245),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            minimumSize:
                                const Size(390, 50), // Đặt kích thước cố định
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
